--[[
	Server-side script for persisting backpack favorites across sessions.
	Uses DataStoreService to save/load favorite tool names per player.
	
	Note: The BackpackFavorites folder with RemoteEvent and RemoteFunction
	is defined in BackpackFavorites.model.json and should be placed in ReplicatedStorage.
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- DataStore for storing player favorites
local BackpackFavoritesStore = DataStoreService:GetDataStore("BackpackFavorites")

-- Get references to the remotes (created by the JSON model)
local FavoritesRemote = script.Parent.Parent:WaitForChild("BackpackFavorites")
local SaveFavoriteEvent = FavoritesRemote:WaitForChild("SaveFavorite") :: RemoteEvent
local RequestFavoritesFunction = FavoritesRemote:WaitForChild("RequestFavorites") :: RemoteFunction

-- Cache of player favorites (in-memory)
local PlayerFavoritesCache: { [Player]: { [string]: { IsFavorited: boolean, FavoritedTime: number } } } = {}

-- Load player favorites from DataStore
local function LoadPlayerFavorites(player: Player): { [string]: { IsFavorited: boolean, FavoritedTime: number } }?
	local userId = "Player_" .. player.UserId
	local success, result = pcall(function()
		return BackpackFavoritesStore:GetAsync(userId)
	end)

	if success then
		if result then
			print("[ServerFavorites] Loaded favorites for " .. player.Name .. ":", result)
			return result
		else
			print("[ServerFavorites] No saved favorites for " .. player.Name)
			return {}
		end
	else
		warn("[ServerFavorites] Failed to load favorites for " .. player.Name .. ":", result)
		return {}
	end
end

-- Save player favorites to DataStore
local function SavePlayerFavorites(player: Player, favorites: { [string]: { IsFavorited: boolean, FavoritedTime: number } })
	local userId = "Player_" .. player.UserId
	
	-- Only save favorited items (remove unfavorited items from storage)
	local favoritesToSave = {}
	for toolName, data in pairs(favorites) do
		if data.IsFavorited then
			favoritesToSave[toolName] = data
		end
	end
	
	local success, errorMessage = pcall(function()
		BackpackFavoritesStore:SetAsync(userId, favoritesToSave)
	end)

	if success then
		print("[ServerFavorites] Saved favorites for " .. player.Name)
	else
		warn("[ServerFavorites] Failed to save favorites for " .. player.Name .. ":", errorMessage)
	end
end

-- Handle favorite toggle from client
SaveFavoriteEvent.OnServerEvent:Connect(function(player: Player, toolName: string, isFavorited: boolean, favoritedTime: number?)
	if not player or not toolName or typeof(toolName) ~= "string" then
		warn("[ServerFavorites] Invalid favorite toggle request from " .. tostring(player))
		return
	end

	-- Initialize cache if needed
	if not PlayerFavoritesCache[player] then
		PlayerFavoritesCache[player] = {}
	end

	-- Update cache
	if isFavorited then
		PlayerFavoritesCache[player][toolName] = {
			IsFavorited = true,
			FavoritedTime = favoritedTime or os.time()
		}
	else
		-- Remove from cache when unfavorited
		PlayerFavoritesCache[player][toolName] = {
			IsFavorited = false,
			FavoritedTime = nil
		}
	end

	print("[ServerFavorites] Updated favorite for " .. player.Name .. ": " .. toolName .. " = " .. tostring(isFavorited))

	-- Save immediately (as per user requirement)
	SavePlayerFavorites(player, PlayerFavoritesCache[player])
end)

-- Handle request for favorites from client
RequestFavoritesFunction.OnServerInvoke = function(player: Player): { [string]: { IsFavorited: boolean, FavoritedTime: number } }?
	if PlayerFavoritesCache[player] then
		return PlayerFavoritesCache[player]
	end

	-- If not in cache, load from DataStore
	local favorites = LoadPlayerFavorites(player)
	PlayerFavoritesCache[player] = favorites or {}
	return PlayerFavoritesCache[player]
end

-- When player joins, load their favorites
Players.PlayerAdded:Connect(function(player: Player)
	local favorites = LoadPlayerFavorites(player)
	PlayerFavoritesCache[player] = favorites or {}
end)

-- When player leaves, save their favorites and clear cache
Players.PlayerRemoving:Connect(function(player: Player)
	if PlayerFavoritesCache[player] then
		SavePlayerFavorites(player, PlayerFavoritesCache[player])
		PlayerFavoritesCache[player] = nil
	end
end)

print("[ServerFavorites] Server favorites system initialized")

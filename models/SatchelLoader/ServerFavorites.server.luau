--[[
	Server-side script for persisting backpack favorites across sessions.
	Uses DataStoreService to save/load favorite tool names per player.
	
	Note: The BackpackFavorites folder with RemoteEvent and RemoteFunction
	is defined in BackpackFavorites.model.json and should be placed in ReplicatedStorage.
	
	SECURITY:
	- Validates tool ownership before allowing favorites
	- Rate limits requests to prevent spam
	- Validates string lengths and data types
	- Enforces maximum favorites limit
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Security Configuration
local MAX_TOOL_NAME_LENGTH = 100 -- Maximum characters for tool name
local MAX_FAVORITES_PER_PLAYER = 10000 -- Maximum number of favorited items (supports large collections)
local RATE_LIMIT_WINDOW = 1 -- Seconds
local RATE_LIMIT_MAX_REQUESTS = 5 -- Max requests per window

-- DataStore for storing player favorites
local BackpackFavoritesStore = DataStoreService:GetDataStore("BackpackFavorites")

-- Get references to the remotes (created by the JSON model)
local FavoritesRemote = script.Parent.Parent:WaitForChild("BackpackFavorites")
local SaveFavoriteEvent = FavoritesRemote:WaitForChild("SaveFavorite") :: RemoteEvent
local RequestFavoritesFunction = FavoritesRemote:WaitForChild("RequestFavorites") :: RemoteFunction

-- Cache of player favorites (in-memory)
local PlayerFavoritesCache: { [Player]: { [string]: { IsFavorited: boolean, FavoritedTime: number } } } = {}

-- Rate limiting tracking
local RateLimitData: { [Player]: { lastRequest: number, requestCount: number } } = {}

-- Validate that player owns the tool
local function PlayerOwnsTool(player: Player, toolName: string): boolean
	-- Check backpack
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		local tool = backpack:FindFirstChild(toolName)
		if tool and tool:IsA("Tool") then
			return true
		end
	end
	
	-- Check equipped (character)
	local character = player.Character
	if character then
		local tool = character:FindFirstChild(toolName)
		if tool and tool:IsA("Tool") then
			return true
		end
	end
	
	return false
end

-- Rate limiting check
local function CheckRateLimit(player: Player): boolean
	local now = os.clock()
	local data = RateLimitData[player]
	
	if not data then
		RateLimitData[player] = {
			lastRequest = now,
			requestCount = 1
		}
		return true
	end
	
	-- Reset if outside window
	if now - data.lastRequest > RATE_LIMIT_WINDOW then
		data.lastRequest = now
		data.requestCount = 1
		return true
	end
	
	-- Check if exceeded limit
	if data.requestCount >= RATE_LIMIT_MAX_REQUESTS then
		warn("[ServerFavorites] Rate limit exceeded for " .. player.Name)
		return false
	end
	
	data.requestCount = data.requestCount + 1
	return true
end

-- Validate input data
local function ValidateInput(toolName: any, isFavorited: any): (boolean, string?)
	-- Type checks
	if typeof(toolName) ~= "string" then
		return false, "toolName must be a string"
	end
	
	if typeof(isFavorited) ~= "boolean" then
		return false, "isFavorited must be a boolean"
	end
	
	-- String length check
	if #toolName > MAX_TOOL_NAME_LENGTH then
		return false, "toolName exceeds maximum length"
	end
	
	-- Empty string check
	if #toolName == 0 then
		return false, "toolName cannot be empty"
	end
	
	-- Sanitize: check for null bytes or other problematic characters
	if toolName:find("%z") then
		return false, "toolName contains invalid characters"
	end
	
	return true
end

-- Load player favorites from DataStore
local function LoadPlayerFavorites(player: Player): { [string]: { IsFavorited: boolean, FavoritedTime: number } }?
	local userId = "Player_" .. player.UserId
	local success, result = pcall(function()
		return BackpackFavoritesStore:GetAsync(userId)
	end)

	if success then
		if result and typeof(result) == "table" then
			print("[ServerFavorites] Loaded favorites for " .. player.Name)
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
	local count = 0
	
	for toolName, data in pairs(favorites) do
		if data.IsFavorited and count < MAX_FAVORITES_PER_PLAYER then
			favoritesToSave[toolName] = data
			count = count + 1
		end
	end
	
	local success, errorMessage = pcall(function()
		BackpackFavoritesStore:SetAsync(userId, favoritesToSave)
	end)

	if success then
		print("[ServerFavorites] Saved " .. count .. " favorites for " .. player.Name)
	else
		warn("[ServerFavorites] Failed to save favorites for " .. player.Name .. ":", errorMessage)
	end
end

-- Handle favorite toggle from client
SaveFavoriteEvent.OnServerEvent:Connect(function(player: Player, toolName: any, isFavorited: any, favoritedTime: any)
	-- Basic player check
	if not player then
		return
	end
	
	-- Rate limiting
	if not CheckRateLimit(player) then
		return
	end
	
	-- Validate input
	local valid, errorMsg = ValidateInput(toolName, isFavorited)
	if not valid then
		warn("[ServerFavorites] Invalid input from " .. player.Name .. ": " .. (errorMsg or "unknown"))
		return
	end
	
	-- Verify tool ownership (CRITICAL SECURITY CHECK)
	if not PlayerOwnsTool(player, toolName) then
		warn("[ServerFavorites] Player " .. player.Name .. " does not own tool: " .. toolName)
		return
	end
	
	-- Initialize cache if needed
	if not PlayerFavoritesCache[player] then
		PlayerFavoritesCache[player] = {}
	end
	
	-- Check favorites limit
	if isFavorited then
		local currentCount = 0
		for _, data in pairs(PlayerFavoritesCache[player]) do
			if data.IsFavorited then
				currentCount = currentCount + 1
			end
		end
		
		if currentCount >= MAX_FAVORITES_PER_PLAYER then
			warn("[ServerFavorites] Player " .. player.Name .. " exceeded favorites limit")
			return
		end
	end
	
	-- Validate timestamp (use server time to prevent manipulation)
	local serverTime = os.time()
	
	-- Update cache
	if isFavorited then
		PlayerFavoritesCache[player][toolName] = {
			IsFavorited = true,
			FavoritedTime = serverTime  -- Always use server time
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
	if not player then
		return {}
	end
	
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
	
	-- Clean up rate limit data
	RateLimitData[player] = nil
end)

print("[ServerFavorites] Server favorites system initialized with security features")

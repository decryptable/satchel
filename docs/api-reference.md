<style>
    .md-typeset__table {
      width: 100%;
    }

    .md-typeset__table table:not([class]) {
      display: table
    }
</style>

Satchel is a reskin of the default BackpackGui located in [CoreGui]. Satchel acts very similar to the default backpack and is based on a fork on the default backpack. Behaviors between the two should remain the same with both of them managing the [Backpack].

[CoreGui]: https://create.roblox.com/docs/reference/engine/classes/CoreGui
[Backpack]: https://create.roblox.com/docs/reference/engine/classes/Backpack

## Summary

### Attributes

| Attribute                                                                                       | Description                                                                                  | Default           |
| :---------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- | :---------------- |
| BackgroundColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)  | Determines the background color of the default inventory window and slots.                   | `[25, 27, 29]`    |
| BackgroundTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers)       | Determines the background transparency of the default inventory window and slots.            | 0.3               |
| CornerRadius: [`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim)          | Determines the radius, in pixels, of the default inventory window and slots.                 | `0, 8`            |
| EquipBorderColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the equip border when a slot is equipped.                            | `[255, 255, 255]` |
| EquipBorderSizePixel: [`number`](https://create.roblox.com/docs/scripting/luau/numbers)         | Determines the pixel width of the equip border when a slot is equipped.                      | `5`               |
| FontFace: [`Font`](https://create.roblox.com/docs/reference/engine/enums/Font)                  | Determines the font of the default inventory window and slots.                               | `Builder Sans`    |
| InsetIconPadding: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans)           | Determines whether or not the tool icon is padded in the default inventory window and slots. | True              |
| OutlineEquipBorder: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans)         | Determines whether or not the equip border is outline or inset when a slot is equipped.      | True              |
| TextColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)        | Determines the color of the text in default inventory window and slots.                      | `[255, 255, 255]` |
| TextSize: [`number`](https://create.roblox.com/docs/scripting/luau/numbers)                     | Determines the size of the text in the default inventory window and slots.                   | `14`              |
| TextStrokeColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)  | Determines the color of the text stroke of text in default inventory window and slots.       | `[0, 0, 0]`       |
| TextStrokeTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers)       | Determines the transparency of the text stroke of text in default chat window and slots.     | 0.5               |

### Methods

| IsOpened(): [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) |
| :------------------------------------------------------------------------------ |
| Returns whether the inventory is opened or not.                                 |

| SetBackpackEnabled(enabled: boolean): `void`          |
| :---------------------------------------------------- |
| Sets whether the backpack gui is enabled or disabled. |

| GetBackpackEnabled(): [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) |
| :---------------------------------------------------------------------------------------- |
| Returns whether the backpack gui is enabled or disabled.                                  |

| GetStateChangedEvent(): [`RBXScriptSignal`](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) |
| :--------------------------------------------------------------------------------------------------------------------- |
| Returns a signal that fires when the inventory is opened or closed.                                                    |

| SetFavorite(tool: Tool, favorited: boolean): `void`                                                        |
| :--------------------------------------------------------------------------------------------------------- |
| Sets the favorite status of a tool. Only works if the tool has the `CanBeFavorited` attribute set to true. |

| IsFavorited(tool: Tool): [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) |
| :------------------------------------------------------------------------------------------- |
| Returns whether a tool is favorited. Returns false if the tool cannot be favorited.          |

| GetFavoritedTools(): `{Tool}`                                                                    |
| :----------------------------------------------------------------------------------------------- |
| Returns a list of all currently favorited tools in the player's backpack and equipped character. |

## Attributes

### BackgroundColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the background color of the default inventory window and slots. Changing this will update the background color for all elements excluding the search box background for visibility purposes.

### BackgroundTransparency

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the background transparency of the default inventory window and slots. This will change how the hot bar looks in its locked state and the inventory background.

### CornerRadius

[`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim)

Determines the radius, in pixels, of the default inventory window and slots. This will affect all elements with a visible rounded corner. The corner radius for the search bar is calculated automatically based on this value.

### EquipBorderColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the equip border when a slot is equipped. The drag outline color of the slot will not changed by this.

### EquipBorderSizePixel

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the pixel width of the equip border when a slot is equipped. This additionally controls the padding of tool icons. Default is 0.5 for a thin, modern border.

### FontFace

[`Enum.Font`](https://create.roblox.com/docs/reference/engine/enums/Font)

Determines the font of the default inventory window and slots. This includes all text in the Satchel UI.

!!! bug

    Rojo does not support the [Font](https://create.roblox.com/docs/reference/engine/datatypes/Font) instance attribute so the it will not be synced. You may add the attribute manually if you wish to adjust the font.

### InsetIconPadding

[`bool`](https://create.roblox.com/docs/luau/booleans)

Determines whether or not the tool icon is padded in the default inventory window and slots. Changing this will change how the tool icon is padded in the slot or not.

### OutlineEquipBorder

[`bool`](https://create.roblox.com/docs/luau/booleans)

Determines whether or not the equip border is outline or inset when a slot is equipped. Changing this will make the equip border either border will outline or inset the slot.

### TextColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the text in default inventory window and slots. This will change the color of all text.

### TextSize

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the size of the text in the default inventory window and slots. This will change the text size of the tool names and will not change other text like search text, hotkey number, and gamepad hints.

### TextStrokeColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the text stroke of text in default inventory window and slots. This will change the color of all text strokes which are visible.

### TextStrokeTransparency

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the transparency of the text stroke of text in default chat window and slots. This will change all text strokes in which text strokes are visible.

## Methods

### IsOpened

Returns whether the inventory is opened or not.

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
    </tr>
</table>

### SetBackpackEnabled

Sets whether the backpack gui is enabled or disabled.

#### Code Samples

This code sample will disable the backpack gui.

```lua title="Disable Backpack"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

Satchel.SetBackpackEnabled(false)
```

#### Parameters

<table>
    <tr>
        <td>enabled: <a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
        <td>Whether to enable or disable the Backpack</td>
    </tr>
</table>

#### Returns

<table>
    <tr>
        <td>void</td>
    </tr>
</table>

### GetBackpackEnabled

Returns whether the backpack gui is enabled or disabled.

#### Code Samples

This code sample makes a TextButton that toggles the inventory when clicked.

```lua title="Toggle Satchel"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

local button = Instance.new("TextButton")
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Position = UDim2.new(0.5, 0, 0.5, 0)
button.Text = "Toggle Inventory"
button.MouseButton1Click:Connect(function()
    if Satchel:GetBackpackEnabled() then
        Satchel.SetBackpackEnabled(false)
    else
        Satchel.SetBackpackEnabled(true)
    end
end)
```

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
    </tr>
</table>

### GetStateChangedEvent

Returns a signal that fires when the inventory is opened or closed.

#### Code Samples

This code sample detects when the inventory is opened or closed.

```lua title="Detect Inventory State"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

Satchel.GetStateChangedEvent():Connect(function(isOpened: boolean)
    if isOpened then
        print("Inventory opened")
    else
        print("Inventory closed")
    end
end)
```

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal">RBXScriptSignal</a></td>
    </tr>
</table>

### SetFavorite

Sets the favorite status of a tool. This method only works if the tool has the `CanBeFavorited` attribute set to `true`. Favorited items are protected from bulk operations and are automatically sorted to the top of the inventory.

#### Code Samples

This code sample marks a tool as favorited when the player picks it up.

```lua title="Auto-favorite Specific Tool"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Satchel = require(ReplicatedStorage.Satchel)
local player = Players.LocalPlayer

player.Backpack.ChildAdded:Connect(function(tool)
    if tool.Name == "SpecialSword" and tool:IsA("Tool") then
        -- Set the tool as favoritable first
        tool:SetAttribute("CanBeFavorited", true)
        -- Then favorite it
        Satchel:SetFavorite(tool, true)
    end
end)
```

#### Parameters

<table>
    <tr>
        <td>tool: <a href="https://create.roblox.com/docs/reference/engine/classes/Tool">Tool</a></td>
        <td>The tool to set the favorite status for</td>
    </tr>
    <tr>
        <td>favorited: <a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
        <td>Whether to favorite (true) or unfavorite (false) the tool</td>
    </tr>
</table>

#### Returns

<table>
    <tr>
        <td>void</td>
    </tr>
</table>

### IsFavorited

Returns whether a tool is currently favorited. Returns `false` if the tool cannot be favorited (doesn't have `CanBeFavorited` attribute set to `true`).

#### Code Samples

This code sample prevents selling favorited items.

```lua title="Protect Favorited Items"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

local function canSellTool(tool: Tool): boolean
    -- Check if the tool is favorited
    if Satchel:IsFavorited(tool) then
        return false -- Don't allow selling favorited items
    end
    return true
end

-- Example usage
local function sellTool(tool: Tool)
    if canSellTool(tool) then
        -- Sell the tool
        print("Selling:", tool.Name)
        tool:Destroy()
    else
        print("Cannot sell favorited item:", tool.Name)
    end
end
```

#### Parameters

<table>
    <tr>
        <td>tool: <a href="https://create.roblox.com/docs/reference/engine/classes/Tool">Tool</a></td>
        <td>The tool to check favorite status for</td>
    </tr>
</table>

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
    </tr>
</table>

### GetFavoritedTools

Returns a list of all currently favorited tools in the player's backpack and equipped on the character. Only returns tools that have `CanBeFavorited` set to `true`.

#### Code Samples

This code sample lists all favorited tools.

```lua title="List Favorited Tools"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

local function printFavoritedTools()
    local favoritedTools = Satchel:GetFavoritedTools()

    if #favoritedTools == 0 then
        print("No favorited tools")
    else
        print("Favorited tools:")
        for _, tool in favoritedTools do
            print("-", tool.Name)
        end
    end
end

printFavoritedTools()
```

This code sample creates a "sell all non-favorited items" feature.

```lua title="Sell All Except Favorites"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Satchel = require(ReplicatedStorage.Satchel)
local player = Players.LocalPlayer

local function sellAllExceptFavorites()
    local favoritedTools = Satchel:GetFavoritedTools()
    local favoritedSet = {}

    -- Create a set for faster lookup
    for _, tool in favoritedTools do
        favoritedSet[tool] = true
    end

    -- Sell all tools not in the favorited set
    for _, tool in player.Backpack:GetChildren() do
        if tool:IsA("Tool") and not favoritedSet[tool] then
            print("Selling:", tool.Name)
            tool:Destroy() -- Replace with actual sell logic
        end
    end
end
```

#### Returns

<table>
    <tr>
        <td>{<a href="https://create.roblox.com/docs/reference/engine/classes/Tool">Tool</a>}</td>
    </tr>
</table>

## Favorites System

### Overview

Satchel includes a built-in favorites system that allows players to mark important items and protect them from bulk operations. The system includes:

- **Visual Indicator**: A gold star (⭐) appears on favorited items in the bottom-right corner
- **Auto-Sorting**: Favorited items automatically sort to the top of the inventory by most recently favorited
- **Favoritable Filter**: A futuristic toggle switch in the Favorites Control Panel to show only favorited items
- **Golden Background**: Items that can be favorited have a golden/bronze background tint
- **Thin Selection Border**: Selected items now have a thinner (0.5px) modern border

### How Players Favorite Items

Players can favorite items using two methods:

1. **Desktop**: Right-click on an item in the inventory
2. **Mobile/Touch**: Long-press (hold for 0.5 seconds) on an item

### Setting Up Favoritable Items

By default, tools **cannot** be favorited unless they have the `CanBeFavorited` attribute set to `true`. This prevents favoriting of default/non-collectible items.

```lua title="Make Tool Favoritable"
-- Make a tool favoritable
local tool = script.Parent
tool:SetAttribute("CanBeFavorited", true)
```

```lua title="Batch Setup"
-- Make all tools in a folder favoritable
local CollectiblesFolder = game.ServerStorage.Collectibles

for _, tool in CollectiblesFolder:GetChildren() do
    if tool:IsA("Tool") then
        tool:SetAttribute("CanBeFavorited", true)
    end
end
```

### Integration Example

Here's a complete example showing how to integrate the favorites system into a selling script:

```lua title="Complete Sell System with Favorites"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Satchel = require(ReplicatedStorage.Satchel)
local player = Players.LocalPlayer

-- Sell a single tool
local function sellTool(tool: Tool): boolean
    if not tool or not tool:IsA("Tool") then
        return false
    end

    -- Check if favorited
    if Satchel:IsFavorited(tool) then
        warn("Cannot sell favorited item:", tool.Name)
        return false
    end

    -- Sell the tool
    print("Selling:", tool.Name)
    tool:Destroy() -- Replace with actual sell logic
    return true
end

-- Sell all non-favorited tools
local function sellAllNonFavorites()
    local favoritedTools = Satchel:GetFavoritedTools()
    local favoritedSet = {}

    for _, tool in favoritedTools do
        favoritedSet[tool] = true
    end

    local soldCount = 0
    for _, tool in player.Backpack:GetChildren() do
        if tool:IsA("Tool") and not favoritedSet[tool] then
            if sellTool(tool) then
                soldCount += 1
            end
        end
    end

    print("Sold", soldCount, "items")
end

-- Example: Create a button to sell all
local sellButton = Instance.new("TextButton")
sellButton.Text = "Sell All (Keep Favorites)"
sellButton.MouseButton1Click:Connect(sellAllNonFavorites)
```

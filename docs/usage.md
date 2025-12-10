Use of Satchel after installation very easy. Just [publish your experience to Roblox] and see Satchel live in action.

To learn how to install Satchel, see [Installation].

!!! note

    Please see [API Reference] for more details on attributes, methods, and events for Satchel and how to use Satchel to it's full potential.

[publish your experience to Roblox]: https://create.roblox.com/docs/production/publishing
[Installation]: installation.md
[API Reference]: api-reference.md

### Customization

Satchel is highly customizable & adjustable with [instance attributes] support allowing you to customize the behavior and appearance of over 10+ attributes.

Some of the attributes include:

- Text Color, Size, Stroke Color & Transparency
- Background Color & Transparency
- Equip Border Color & Thickness
- Corner Radius
- Font

More attributes can be found in the [API Reference]. The list above is not exhaustive and there are may more attributes available for customization.

[instance attributes]: https://create.roblox.com/docs/studio/instance-attributes

<figure markdown>
  ![Instance Attributes](assets/attributes-example.png)
  <figcaption>Example of customization using instance attributes</figcaption>
</figure>

### Scripting

Satchel offers methods and events for scripting purposes. In the below code example we will use the `SetBackpackEnabled` method to disable the Satchel. The script expects the Satchel module to be in [`ReplicatedStorage`][ReplicatedStorage].

```lua title="Disable Backpack"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

Satchel.SetBackpackEnabled(false)
```

For the full API reference, see [API Reference] for more details on attributes, methods, and events for Satchel and how to use Satchel to it's full potential.

[ReplicatedStorage]: https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage
[SetBackpackEnabled]: api-reference.md#setbackpackenabled

### Favorites System

Satchel includes a built-in favorites system that allows players to protect important items from being accidentally sold or discarded. This feature is particularly useful for games with collectible items, trading systems, or inventory management.

#### Player Experience

Players can favorite items using:

- **Desktop**: Right-click on any item
- **Mobile/Touch**: Long-press (0.5 seconds) on any item

Favorited items are marked with a gold star ⭐ in the bottom-right corner and automatically sort to the top of the inventory.

#### Visual Features

- **Golden Background**: Items that can be favorited have a distinctive golden/bronze background
- **Favorites Control Panel**: A dedicated panel above the inventory with:
  - Helper text explaining how to favorite items
  - Futuristic animated toggle switch to filter inventory (show all / favorites only)
- **Auto-Sorting**: Favorited items automatically appear first, sorted by most recently favorited
- **Real-time Updates**: The filter updates immediately when items are favorited/unfavorited

#### Developer Setup

To enable favorites for specific items, set the `CanBeFavorited` attribute:

```lua title="Make Items Favoritable"
local tool = game.ServerStorage.SpecialSword
tool:SetAttribute("CanBeFavorited", true)
```

For integration with sell/trade systems, see the [Favorites System] section in the API Reference.

[Favorites System]: api-reference.md#favorites-system

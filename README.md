# siro_businesscard
We provide a business card system to facilitate RP. Only works in the QBCore/ox_inventory environment.

# 🪪 QBCore / ox_inventory Business Card Display System

## Features
- Display a large business card image on screen when the item is used  
- Fully customizable via `config.lua`  
- Supports both **ox_inventory** and **QBCore** frameworks  
- Smooth open/close animation  
- Close with **ESC key** or mouse click  
- Share your business card and enhance your RP experience

---
### 🔗 Dependencies
qb-core
ox_inventory
ox_lib

## 📦 Installation

### 1. Place the files
Place the folder into your resources directory (e.g. `resources/businesscard/`)  
*(You can rename or move it to any folder you prefer.)*

### 2. Add your business card images
Put your business card image(s) in:  
`html/images/`

**Recommended image sizes:**
- 1920x1080px → full screen  
- 1280x720px → centered large display  
**Format:** PNG (supports transparency)

### 3. Add to `server.cfg`
```cfg
ensure businesscard
```

### 4. Add the item to ox_inventory and configure export
Add this to ox_inventory/data/items.lua:
```
['business_card_1'] = {
    label = 'Business Card 1',
    weight = 10,
    stack = true,
    close = true,
    description = 'Business card item',
    client = {
        export = 'siro_businesscard.useCard'
    }
},
['business_card_2'] = {
    label = 'Business Card 1',
    weight = 10,
    stack = true,
    close = true,
    description = 'Business card item',
    client = {
        export = 'siro_businesscard.useCard'
    }
},
```

### ⚙️ Customization
Add new business cards in config.lua
```
Config.BusinessCards = {
    ['business_card_1'] = { -- must match the item name in items.lua
        name = 'Display Name',
        image = 'html/images/your_image.png',
        description = 'Your description here'
    },
    ['business_card_2'] = { -- must match the item name in items.lua
        name = 'Display Name',
        image = 'html/images/your_image.png',
        description = 'Your description here'
    },
}
```

### Image setup steps
1. Place your PNG image in html/images/
2. Specify the image path in config.lua
3. Register the corresponding item in ox_inventory/data/items.lua

### 🖱️ How to Use
1. Right-click the business card item in your inventory and select Use
2. The business card will appear in the center of the screen
3. Close it by pressing ESC or clicking the close button

### 🧰 Troubleshooting
#### Image not showing
- Check that the image path is correct
- Make sure the image file actually exists
- Verify the files section in fxmanifest.lua includes your image folder

#### Item not usable
- Confirm the item is correctly added in ox_inventory/data/items.lua
- Ensure the client export function is set properly
- Check resource start order (should be ox_inventory → siro_businesscard)

#### Debug mode
Set Config.Debug = true in config.lua to enable detailed logging.



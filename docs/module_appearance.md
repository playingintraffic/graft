# Appearance Module

Can be used to create character creation scripts, clothing menus, etc.

## Client Functions

### get_clothing_and_prop_values

Returns maximum valid variation values for clothing/hair UI inputs.

#### Params

* `sex` (string): "m" or "f" to indicate which ped model.

#### Returns

* `table`: Max values for hair, fade, eyebrow, mask, and mask_texture.

```lua
local values = appearance.get_clothing_and_prop_values("m")
```

---

### set_ped_appearance

Applies full appearance settings to a freemode ped.

#### Params

* `player` (number): The ped to apply appearance to.
* `data` (table): Appearance config.
  * `genetics`: Facial shape, blend, eye color.
  * `barber`: Hair, overlays, makeup.
  * `clothing`: Style/texture for clothing and props.
  * `tattoos`: Zone-based tattoo data.
  * `sex`: "m" or "f", used for tattoo hash selection.

```lua
appearance.set_ped_appearance(PlayerPedId(), ped_data)
```

---

### update_ped_appearance

Updates a specific field or group in the style table and re-applies appearance.

#### Params

* `sex` (string): "m" or "f"
* `category` (string): "genetics", "barber", "clothing", or "tattoos"
* `id` (string|nil): Specific field (e.g. "eye_colour", "ZONE_HEAD", etc.)
* `value` (any): New value or object to set/insert

```lua
appearance.update_ped_appearance("m", "barber", "hair", 4)
```

---

### change_player_ped

Changes the current player model and reapplies appearance.

#### Params

* `sex` (string): "m" or "f"

```lua
appearance.change_player_ped("f")
```

---

### appearance_rotate_ped

Rotates or resets the player's ped heading.

#### Params

* `direction` (string): "right", "left", "flip", or "reset"

```lua
appearance.appearance_rotate_ped("flip")
```

---

### load_player_appearance

Loads and applies all appearance data to the player model.

#### Params

* `data` (table): Full character data
  * `identity.sex`: "m" or "f"
  * `style.genetics`: Blend + facial features
  * `style.barber`: Hair and overlays
  * `style.clothing`: Clothes and props
  * `style.tattoos`: Tattoo zones and data

```lua
appearance.load_player_appearance(my_data)
```

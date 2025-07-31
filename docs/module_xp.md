# XP

Standalone server-side XP system with support for level progression, growth curves, decay, and optional max levels.  
Uses MySQL for persistence. Basic client sync is handled via callback interface.

---

## Server Functions

### calculate_required_xp

Calculates XP needed for next level using exponential growth.

#### Params

* `current_level` (number): Current level.
* `first_level_xp` (number): XP required for level 1.
* `growth_factor` (number): Exponential scaling factor.

#### Returns

* `number`: XP required for next level.

#### Example

```lua
local xp_required = xp.calculate_required_xp(5, 100, 1.2)
```

---

### insert_new_xp

Inserts a new XP record into the database if it doesn’t exist.

#### Params

* `source` (number): Player source.
* `xp_id` (string): ID of the XP entry (e.g., `"planting"`).
* `xp_type` (string): Type/category of XP.

#### Returns

* `boolean|number`: Insert result or false.

---

### init_xp

Initializes XP table for a player from the database.

#### Params

* `source` (number): Player source.

#### Returns

* `table`: XP data indexed by `type_id`.

---

### get_all_xp

Returns all XP entries for a player.

#### Params

* `source` (number): Player source.

#### Returns

* `table`: All XP entries (or fetches them via `init_xp`).

---

### get_xp

Gets a specific XP entry by type and ID.

#### Params

* `source` (number): Player source.
* `xp_type` (string): XP type.
* `xp_id` (string): XP ID.

#### Returns

* `table|nil`: XP data if found.

---

### set_xp

Sets the XP value directly (no levelup).

#### Params

* `source` (number): Player source.
* `xp_type` (string): XP type.
* `xp_id` (string): XP ID.
* `amount` (number): XP amount.

#### Returns

* `boolean`: True if updated.

---

### add_xp

Adds XP and handles automatic level-ups.

#### Params

* `source` (number): Player source.
* `xp_type` (string): XP type.
* `xp_id` (string): XP ID.
* `amount` (number): XP amount to add.

#### Returns

* `boolean`: True if added successfully.

---

### remove_xp

Removes XP and handles level-downs if XP falls below 0.

#### Params

* `source` (number): Player source.
* `xp_type` (string): XP type.
* `xp_id` (string): XP ID.
* `amount` (number): XP amount to remove.

#### Returns

* `boolean`: True if updated.

---

## Client Functions

### get_all

Requests all XP data from server via callback.

#### Returns

* `table|nil`: All XP entries or `nil` if error.

#### Example

```lua
local xp_data = xp.get_all()
```

---

## Notes

* XP data is stored in `utils_xp` table.
* You must define static XP types/config in `UTILS.DATA.xp`.
* XP entries are stored per-player via license identifier.
* Level up/down logic respects optional `max_level` and `growth_factor`.
# Licences

Standalone licence system with optional theory/practical stages, points, revocation, and MySQL persistence.
Used for RP-style permits (e.g., driving, weapons).
Licences are auto-revoked when max points are reached.

---

## Server Functions

### get_licences

Returns all licences associated with a player.

#### Params

* `source` (number): The player source.

#### Returns

* `table`: Licence data by licence ID.

#### Example

```lua
local licences = licences.get_licences(source)
```

---

### get_licence

Fetches a single licence by ID for a player.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID (e.g., `"drivers"`).

#### Returns

* `table|nil`: The licence data or nil if not found.

#### Example

```lua
local driving = licences.get_licence(source, "drivers")
```

---

### add_licence

Grants a player a new licence.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID.

#### Returns

* `boolean`: True if added.

#### Example

```lua
licences.add_licence(source, "drivers")
```

---

### remove_licence

Deletes a licence from a player.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID.

#### Returns

* `boolean`: True if removed.

#### Example

```lua
licences.remove_licence(source, "drivers")
```

---

### add_points

Adds points to a player’s licence.
If the points exceed the max, the licence is marked revoked.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID.
* `points` (number): Points to add.

#### Returns

* `boolean`: True if successful.

#### Example

```lua
licences.add_points(source, "drivers", 3)
```

---

### remove_points

Removes points from a licence.
Will also un-revoke the licence if under max.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID.
* `points` (number): Points to remove.

#### Returns

* `boolean`: True if successful.

#### Example

```lua
licences.remove_points(source, "drivers", 2)
```

---

### update_licence

Updates a player's licence test status.

#### Params

* `source` (number): The player source.
* `licence_id` (string): The licence ID.
* `test_type` (string): `"theory"` or `"practical"`.
* `passed` (boolean): Whether the test was passed.

#### Returns

* `boolean`: True if successful.

#### Example

```lua
licences.update_licence(source, "drivers", "theory", true)
```

---

## Client Functions

### get_licences

Requests all licences from the server.

#### Returns

* `table|nil`: Player licences or nil on failure.

#### Example

```lua
local licences = licences.get_licences()
```
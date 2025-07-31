# Framework Bridge

**Supported Frameworks:** `qb`, `qbx`, `ox`, `esx`, `nd` 

## Server Functions

### get_players
Retrieves all player source IDs on the server.

#### Returns
* `table`: Array of player sources.

```lua
bridge.get_players()
```

---

### get_player
Retrieves the player object from a source ID.

#### Params
* `source` *(number)*: Player source identifier.

#### Returns
* `object`: Player data.

```lua
bridge.get_player(source)
```

---

### get_id_params
Prepares a SQL query condition for identifying players by their citizenid.

#### Params
* `source` *(number)*: Player source identifier.

#### Returns
* `string, table`: Query string and parameter array.

```lua
bridge.get_id_params(source)
```

---

### get_player_id
Returns the citizenid of the player.

#### Params
* `source` *(number)*: Player source identifier.

#### Returns
* `string`: Citizen ID or false if not found.

```lua
bridge.get_player_id(source)
```

---

### get_identity
Returns structured identity info.

#### Params
* `source` *(number)*

#### Returns
* `table`: Identity data.

```lua
bridge.get_identity(source)
```

---

### get_identity_by_id
Finds a player's identity using their citizenid.

#### Params
* `unique_id` *(string)*

#### Returns
* `table`: Identity data.

```lua
bridge.get_identity_by_id(unique_id)
```

---

### get_inventory
Returns the player’s inventory.

#### Params
* `source` *(number)*

#### Returns
* `table`: Inventory data.

```lua
bridge.get_inventory(source)
```

---

### get_item
Retrieves a specific item from player inventory.

#### Params
* `source` *(number)*
* `item_name` *(string)*

#### Returns
* `table|nil`: Item object if found.

```lua
bridge.get_item(source, item_name)
```

---

### has_item
Checks if a player has the specified item.

#### Params
* `source` *(number)*
* `item_name` *(string)*
* `item_amount` *(number, optional)*

#### Returns
* `boolean`

```lua
bridge.has_item(source, item_name, amount)
```

---

### add_item
Adds item(s) to a player’s inventory.

#### Params
* `source` *(number)*
* `item_id` *(string)*
* `amount` *(number)*
* `data` *(table|nil)*

```lua
bridge.add_item(source, item_id, amount, data)
```

---

### remove_item
Removes an item from player inventory.

#### Params
* `source` *(number)*
* `item_id` *(string)*
* `amount` *(number)*

```lua
bridge.remove_item(source, item_id, amount)
```

---

### update_item_data
Updates metadata for a specific item.

#### Params
* `source` *(number)*
* `item_id` *(string)*
* `updates` *(table)*

```lua
bridge.update_item_data(source, item_id, updates)
```

---

### get_balances
Returns player balance table.

#### Params
* `source` *(number)*

```lua
bridge.get_balances(source)
```

---

### get_balance_by_type
Returns specific balance type.

#### Params
* `source` *(number)*
* `balance_type` *(string)*

```lua
bridge.get_balance_by_type(source, type)
```

---

### add_balance
Adds money.

#### Params
* `source` *(number)*
* `balance_type` *(string)*
* `amount` *(number)*

```lua
bridge.add_balance(source, type, amount)
```

---

### remove_balance
Removes money.

#### Params
* `source` *(number)*
* `balance_type` *(string)*
* `amount` *(number)*

```lua
bridge.remove_balance(source, type, amount)
```

---

### get_player_jobs
Gets job data.

#### Params
* `source` *(number)*

```lua
bridge.get_player_jobs(source)
```

---

### player_has_job
Checks player job.

#### Params
* `source` *(number)*
* `job_names` *(table)*
* `check_on_duty` *(bool)*

```lua
bridge.player_has_job(source, {"police"}, true)
```

---

### get_player_job_grade
Returns job grade.

```lua
bridge.get_player_job_grade(source, "police")
```

---

### count_players_by_job
Counts players by job and duty.

```lua
bridge.count_players_by_job({"ambulance"}, true)
```

---

### get_player_job_name

```lua
bridge.get_player_job_name(source)
```

---

### adjust_statuses

```lua
bridge.adjust_statuses(source, {
  hunger = {remove = {min = 5, max = 10}},
  armor = {add = {min = 1, max = 2}},
})
```

---

### register_item

```lua
bridge.register_item("joint", function(source) ... end)
```

---

## Client Functions

### get_data

```lua
bridge.get_data()
```

---

### get_identity

```lua
bridge.get_identity()
```

---

### get_player_id

```lua
bridge.get_player_id()
```
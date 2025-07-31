# Entities

Client-side utility for scanning and identifying nearby entities in the world.

## Client Functions

### get_nearby_entities

Returns all nearby entities from a specific pool.

#### Params

* `pool` (string): The entity pool name (e.g., `CPed`, `CVehicle`, `CObject`).
* `coords` (vector3): Reference point to search from.
* `max_distance` (number): Distance in meters to scan.
* `filter` (function, optional): Return true to include an entity.

#### Returns

* `table`: A list of tables containing `entity` and `coords`.

```lua
entities.get_nearby_entities("CVehicle", GetEntityCoords(PlayerPedId()), 10.0)
```

---

### get_closest_entity

Finds the closest entity of a given type.

#### Params

* `pool` (string): Pool name.
* `coords` (vector3): Reference point.
* `max_distance` (number): Max search distance.
* `filter` (function, optional): Custom logic filter.

#### Returns

* `number|nil`, `vector3|nil`: Closest entity and its coordinates.

```lua
entities.get_closest_entity("CPed", GetEntityCoords(PlayerPedId()), 5.0)
```

---

### get_nearby_objects

Shortcut for nearby `CObject` entities.

#### Params

* `coords` (vector3)
* `max_distance` (number)

#### Returns

* `table`: List of objects and coords.

```lua
entities.get_nearby_objects(GetEntityCoords(PlayerPedId()), 5.0)
```

---

### get_nearby_peds

Nearby non-player peds.

#### Params

* `coords` (vector3)
* `max_distance` (number)

#### Returns

* `table`: List of NPC peds and coords.

```lua
entities.get_nearby_peds(GetEntityCoords(PlayerPedId()), 6.0)
```

---

### get_nearby_players

Returns player peds within range.

#### Params

* `coords` (vector3)
* `max_distance` (number)
* `include_player` (boolean)

#### Returns

* `table`: List of player peds and coords.

```lua
entities.get_nearby_players(GetEntityCoords(PlayerPedId()), 15.0, false)
```

---

### get_nearby_vehicles

Nearby vehicles within range.

#### Params

* `coords` (vector3)
* `max_distance` (number)
* `include_player_vehicle` (boolean)

#### Returns

* `table`: List of vehicles and coords.

```lua
entities.get_nearby_vehicles(GetEntityCoords(PlayerPedId()), 8.0, true)
```

---

### get_closest_object

Closest `CObject` to player.

#### Params

* `coords` (vector3)
* `max_distance` (number)

#### Returns

* `number`, `vector3`: Closest object and location.

```lua
entities.get_closest_object(GetEntityCoords(PlayerPedId()), 5.0)
```

---

### get_closest_ped

Closest NPC ped.

#### Params

* `coords` (vector3)
* `max_distance` (number)

#### Returns

* `number`, `vector3`: Closest ped and coords.

```lua
entities.get_closest_ped(GetEntityCoords(PlayerPedId()), 4.5)
```

---

### get_closest_player

Closest player ped.

#### Params

* `coords` (vector3)
* `max_distance` (number)
* `include_player` (boolean)

#### Returns

* `number`, `vector3`: Closest player ped and coords.

```lua
entities.get_closest_player(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

### get_closest_vehicle

Closest vehicle.

#### Params

* `coords` (vector3)
* `max_distance` (number)
* `include_player_vehicle` (boolean)

#### Returns

* `number`, `vector3`: Closest vehicle and coords.

```lua
entities.get_closest_vehicle(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

### get_entities_in_front_of_player

Raycasts forward to find an entity.

#### Params

* `fov` (number): Field of view angle.
* `distance` (number): Forward scan range.

#### Returns

* `number|nil`: The entity hit, or nil.

```lua
entities.get_entities_in_front_of_player(90, 5.0)
```

---

### get_target_ped

Checks for a target ped in front or finds the nearest one.

#### Params

* `player_ped` (number): The local player's ped.
* `fov` (number)
* `distance` (number)

#### Returns

* `number`, `vector3`: Ped entity and location.

```lua
entities.get_target_ped(PlayerPedId(), 90, 6.0)
```
# Vehicles

Client-side vehicle utility functions.  
Handles diagnostics, properties, damage reports, and spawning logic.

---

## Client Functions

### get_vehicle_plate

Gets the trimmed plate text of a vehicle.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `string`: Plate string.

#### Example

```lua
local plate = vehicles.get_vehicle_plate(veh)
```

---

### get_vehicle_model

Gets the lowercase display name of a vehicle.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `string`: Model name (e.g. `"adder"`).

#### Example

```lua
local model = vehicles.get_vehicle_model(veh)
```

---

### get_doors_broken

Gets a table of broken doors.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: Keyed by door ID as string, value is boolean.

#### Example

```lua
local doors = vehicles.get_doors_broken(veh)
```

---

### get_windows_broken

Gets a table of broken windows.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: Keyed by window ID as string, value is boolean.

---

### get_tyre_burst

Gets burst tyre states.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: Keyed by tyre index as string, value is boolean.

---

### get_vehicle_extras

Gets current extra toggles for a vehicle.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: Keyed by extra ID as string, value is boolean.

---

### get_custom_xenon_color

Gets custom xenon color if defined.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table|nil`: `{ r, g, b }` or `nil`.

---

### get_vehicle_mod

Gets a specific vehicle mod.

#### Params

* `vehicle` (number): Vehicle entity handle.
* `mod_type` (number): Mod index (e.g., `15` for suspension).

#### Returns

* `table`: `{ index = number, variation = boolean }`

---

### get_neon_enabled

Gets neon light enabled states.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: `{ left, right, front, back }` booleans.

---

### get_vehicle_properties

Gets a complete snapshot of vehicle state, mods, maintenance.

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table properties`, `table modifications`, `table maintenance`

---

### get_vehicle_class

Gets the vehicle class name (e.g. "sports", "motorcycles").

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `string`: Class name.

---

### get_vehicle_class_details

Returns class metadata (speed, traction, etc).

#### Params

* `vehicle` (number): Vehicle entity handle.

#### Returns

* `table`: Includes `class_id`, `class_name`, `estimated_max_speed`, etc.

---

### get_vehicle_details

Gets a full description of the nearest or current vehicle.

#### Params

* `use_current_vehicle` (boolean): If true, uses vehicle you're in.

#### Returns

* `table`:
  * `vehicle`, `plate`, `model`,
  * `properties`, `modifications`, `maintenance`,
  * `class`, `class_details`, `is_rear_engine`

---

### spawn_vehicle

Spawns a vehicle based on input config with full optional support for:

* damage states
* maintenance values
* mod installations
* paint, lights, handling

#### Params

* `vehicle_data` (table): Full vehicle spawn config (see below).

#### Returns

* `number`: Vehicle entity handle.

#### Example

```lua
vehicles.spawn_vehicle({
    model = "sultan",
    coords = vec4(0, 0, 72, 0),
    custom_plate = "GRAFTED",
    set_into_vehicle = true,
    mods = {
        max_performance = true,
        bulletproof_tyres = true,
        custom_paint = {
            primary = { r = 10, g = 10, b = 10 },
            secondary = { r = 255, g = 0, b = 0 }
        }
    }
})
```
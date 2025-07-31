# Environment

Provides a set of utilities for interacting with the game world’s environment: time, weather, materials, water, and more.

## Client Functions

### get_weather_name

Returns the name of the weather type from its hash.

#### Params

* `hash` (number): The hash of the weather.

#### Returns

* `string`: The weather name or `"UNKNOWN"`.

```lua
local weather = environment.get_weather_name(GetHashKey("RAIN"))
```

---

### get_game_time

Returns the current in-game time in both raw and formatted forms.

#### Returns

* `table`:
  * `time` (table): `{ hour, minute }`
  * `formatted` (string): `"HH:MM"` format.

```lua
local time = environment.get_game_time()
```

---

### get_game_date

Returns the current in-game date in both raw and formatted forms.

#### Returns

* `table`:
  * `date` (table): `{ day, month, year }`
  * `formatted` (string): `"DD/MM/YYYY"` format.

```lua
local date = environment.get_game_date()
```

---

### get_sunrise_sunset_times

Returns sunrise and sunset times based on weather.

#### Params

* `weather` (string): The weather type (e.g. `"CLEAR"`).

#### Returns

* `table`: `{ sunrise = "HH:MM", sunset = "HH:MM" }`

```lua
local sun = environment.get_sunrise_sunset_times("CLOUDS")
```

---

### is_daytime

Checks if the current in-game time is considered day.

#### Returns

* `boolean`: True if daytime.

```lua
if environment.is_daytime() then ...
```

---

### is_nighttime

Checks if it is currently night in-game.

#### Returns

* `boolean`: True if night.

```lua
if environment.is_nighttime() then ...
```

---

### is_midday

Checks if the current time is around midday.

#### Returns

* `boolean`: True if between 11:00 and 13:00.

```lua
if environment.is_midday() then ...
```

---

### get_current_season

Returns the in-game season based on the current month.

#### Returns

* `string`: `"Winter"`, `"Spring"`, `"Summer"`, or `"Autumn"`

```lua
local season = environment.get_current_season()
```

---

### get_distance_to_water

Returns the vertical distance to the closest water surface.

#### Returns

* `number`: Distance or -1 if not found.

```lua
local water_distance = environment.get_distance_to_water()
```

---

### get_zone_scumminess

Returns the scumminess rating of the player's current zone.

#### Returns

* `number`: Scumminess level (0-5) or -1 if unknown.

```lua
local scum = environment.get_zone_scumminess()
```

---

### get_ground_material

Returns the hash of the material the player is standing on.

#### Returns

* `number`: Material hash.

```lua
local material = environment.get_ground_material()
```

---

### get_wind_direction

Returns the wind direction as a compass abbreviation.

#### Returns

* `string`: One of `"N"`, `"NE"`, `"E"`, `"SE"`, `"S"`, `"SW"`, `"W"`, `"NW"`.

```lua
local wind_dir = environment.get_wind_direction()
```

---

### get_altitude

Returns the player's current Z altitude.

#### Returns

* `number`: Altitude in world units.

```lua
local alt = environment.get_altitude()
```

---

### get_environment_details

Returns a full breakdown of current environment data.

#### Returns

* `table`:
  * `weather` (string)
  * `time` (table)
  * `date` (table)
  * `season` (string)
  * `sunrise_sunset` (table)
  * `is_daytime` (boolean)
  * `distance_to_water` (number)
  * `scumminess` (number)
  * `ground_material` (number)
  * `rain_level` (number)
  * `wind_speed` (number)
  * `wind_direction` (string)
  * `snow_level` (number)
  * `altitude` (number)

```lua
local env = environment.get_environment_details()
```
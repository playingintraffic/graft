# Player

Collection of helper functions related to player position, location, targeting, and animations.  

---

## Shared Functions

### get_cardinal_direction

Gets the cardinal direction the player is facing (e.g., "N", "SW", etc.).

#### Params

* `player_ped` (number): The player ped (`PlayerPedId()` or `GetPlayerPed(source)`).

#### Returns

* `string`: Cardinal direction ("N", "NE", "E", etc.).

#### Example

```lua
local dir = player.get_cardinal_direction(PlayerPedId()) -- "W"
```

---

### get_distance_to_entity

Calculates distance between player and another entity.

#### Params

* `player_ped` (number): The player ped.
* `entity` (number): Entity ID or net ID (on server).

#### Returns

* `number`: Distance between entities.

#### Example

```lua
local dist = player.get_distance_to_entity(PlayerPedId(), targetEntity)
```

---

## Client Functions

### get_street_name

Returns the street and area the player is currently located in.

#### Params

* `player_ped` (number): The player ped.

#### Returns

* `string`: Street and zone name (e.g., `"Grove St, Davis"`).

#### Example

```lua
local location = player.get_street_name(PlayerPedId())
```

---

### get_region

Returns the internal GTA region code of the player’s location.

#### Params

* `player_ped` (number): The player ped.

#### Returns

* `string`: Region code (e.g., `"DAVIS"`).

#### Example

```lua
local region = player.get_region(PlayerPedId())
```

---

### get_player_details

Returns a detailed data table about the player.

#### Params

* `player_ped` (number): The player ped.

#### Returns

* `table`: Table of details:
  * `server_id`, `name`, `coords`, `model_hash`
  * `health`, `armor`, `stamina`, `max_stamina`
  * `melee_damage_modifier`, `melee_defense_modifier`
  * `vehicle_damage_modifier`, `vehicle_defense_modifier`
  * `weapon_damage_modifier`, `weapon_defense_modifier`

#### Example

```lua
local info = player.get_player_details(PlayerPedId())
print(info.health, info.region)
```

---

### get_target_entity

Returns the entity the player is free-aiming at.

#### Params

* `player_ped` (number): The player ped.

#### Returns

* `number`: Entity ID or 0 if not aiming at one.

#### Example

```lua
local target = player.get_target_entity(PlayerPedId())
```

---

### play_animation

Plays an animation on the player with support for:

* timed or continuous playback,
* freezing during the animation,
* attaching props to bones.

#### Params

* `player_ped` (number): The player ped.
* `options` (table): Animation and prop options:
  * `dict`, `anim`, `flags`, `duration`, `playback`, `continuous`
  * `freeze`, `props`, `blend_in`, `blend_out`, `lock_x/y/z`
* `callback` (function): Callback to run once finished (non-continuous only).

#### Returns

* `nil`

#### Example

```lua
player.play_animation(PlayerPedId(), {
    dict = "amb@world_human_smoking@male@male_a@enter",
    anim = "enter",
    duration = 3000,
    freeze = true,
    props = {
        {
            model = "prop_cigar_03",
            bone = 28422,
            coords = vector3(0.0, 0.0, 0.0),
            rotation = vector3(0.0, 0.0, 0.0)
        }
    }
}, function()
    print("Animation finished")
end)
```
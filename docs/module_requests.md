# Requests

Client-side wrapper functions for FiveM's native `Request*` APIs.  
Each function ensures the requested asset is fully loaded before continuing.

---

## Shared Functions

### model

Requests and loads a model.

#### Params

* `model` (hash): Model hash to request.

#### Returns

* `nil`

#### Example

```lua
requests.model(GetHashKey("prop_barrel_02a"))
```

---

### interior

Requests and loads a given interior.

#### Params

* `interior` (number): Interior ID.

#### Returns

* `nil`

#### Example

```lua
local interior = GetInteriorAtCoords(435.0, -980.0, 30.0)
requests.interior(interior)
```

---

### texture

Requests a texture dictionary.

#### Params

* `texture` (string): Texture dictionary name.
* `boolean` (boolean): If true, waits until loaded.

#### Returns

* `nil`

#### Example

```lua
requests.texture("commonmenu", true)
```

---

### collision

Requests collision at a location.

#### Params

* `x` (number): X coordinate.
* `y` (number): Y coordinate.
* `z` (number): Z coordinate.

#### Returns

* `nil`

#### Example

```lua
requests.collision(123.4, 456.7, 78.9)
```

---

### anim

Requests and loads an animation dictionary.

#### Params

* `dict` (string): Animation dictionary name.

#### Returns

* `nil`

#### Example

```lua
requests.anim("amb@world_human_cheering@male_a")
```

---

### anim\_set

Requests and loads an animation set.

#### Params

* `set` (string): Animation set name.

#### Returns

* `nil`

#### Example

```lua
requests.anim_set("move_m@drunk@verydrunk")
```

---

### clip\_set

Requests and loads a movement clipset.

#### Params

* `clip` (string): Clipset name.

#### Returns

* `nil`

#### Example

```lua
requests.clip_set("move_m@business@a")
```

---

### audio\_bank

Requests and loads a script audio bank.

#### Params

* `audio` (string): Audio bank name.

#### Returns

* `nil`

#### Example

```lua
requests.audio_bank("DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
```

---

### scaleform\_movie

Requests and loads a scaleform movie.

#### Params

* `scaleform` (string): Name of the scaleform movie.

#### Returns

* `number`: Handle to the loaded scaleform.

#### Example

```lua
local handle = requests.scaleform_movie("instructional_buttons")
```

---

### cutscene

Requests and loads a cutscene.

#### Params

* `scene` (string): Name of the cutscene.

#### Returns

* `nil`

#### Example

```lua
requests.cutscene("mp_intro_concat")
```

---

### ipl

Requests and activates an IPL (Interior Proxy Library).

#### Params

* `str` (string): IPL name.

#### Returns

* `nil`

#### Example

```lua
requests.ipl("hei_bi_hw1_13_door")
```
# Maths

Additional math utility functions not included in Lua’s default `math` library.

---

## Server Functions

### round

Rounds a number to the specified number of decimal places.

#### Params

* `number` (number): The number to round.
* `decimals` (number): Decimal places to round to.

#### Returns

* `number`: The rounded number.

#### Example

```lua
local result = maths.round(3.14159, 2) -- 3.14
```

---

### calculate_distance

Calculates distance between two 3D vectors.

#### Params

* `start_coords` (vector3): Starting coordinates.
* `end_coords` (vector3): Ending coordinates.

#### Returns

* `number`: The distance between points.

#### Example

```lua
local dist = maths.calculate_distance(vec3(0,0,0), vec3(3,4,0)) -- 5.0
```

---

### clamp

Clamps a number within a minimum and maximum.

#### Params

* `val` (number): Value to clamp.
* `lower` (number): Minimum limit.
* `upper` (number): Maximum limit.

#### Returns

* `number`: Clamped value.

#### Example

```lua
local clamped = maths.clamp(11, 0, 10) -- 10
```

---

### lerp

Linearly interpolates between two numbers.

#### Params

* `a` (number): Start value.
* `b` (number): End value.
* `t` (number): Interpolation factor (0–1).

#### Returns

* `number`: Interpolated result.

#### Example

```lua
local halfway = maths.lerp(10, 20, 0.5) -- 15
```

---

### factorial

Calculates the factorial of a number.

#### Params

* `n` (number): Input number.

#### Returns

* `number`: Factorial result.

#### Example

```lua
local result = maths.factorial(5) -- 120
```

---

### deg_to_rad

Converts degrees to radians.

#### Params

* `deg` (number): Angle in degrees.

#### Returns

* `number`: Angle in radians.

#### Example

```lua
local radians = maths.deg_to_rad(180) -- π
```

---

### rad_to_deg

Converts radians to degrees.

#### Params

* `rad` (number): Angle in radians.

#### Returns

* `number`: Angle in degrees.

#### Example

```lua
local degrees = maths.rad_to_deg(math.pi) -- 180
```

---

### circle_circumference

Calculates the circumference of a circle.

#### Params

* `radius` (number): Radius of the circle.

#### Returns

* `number`: Circumference.

#### Example

```lua
local c = maths.circle_circumference(5) -- ~31.42
```

---

### circle_area

Calculates the area of a circle.

#### Params

* `radius` (number): Radius of the circle.

#### Returns

* `number`: Area.

#### Example

```lua
local a = maths.circle_area(5) -- ~78.54
```

---

### triangle_area

Calculates area of a triangle from 2D points.

#### Params

* `p1` (table): First point `{x=, y=}`.
* `p2` (table): Second point.
* `p3` (table): Third point.

#### Returns

* `number`: Triangle area.

#### Example

```lua
local area = maths.triangle_area({x=0,y=0}, {x=5,y=0}, {x=0,y=5}) -- 12.5
```

---

### mean

Calculates the average of numbers.

#### Params

* `numbers` (table): List of numbers.

#### Returns

* `number`: The mean.

#### Example

```lua
local avg = maths.mean({2, 4, 6}) -- 4
```

---

### median

Calculates the median value.

#### Params

* `numbers` (table): List of numbers.

#### Returns

* `number`: The median.

#### Example

```lua
local mid = maths.median({1, 5, 3}) -- 3
```

---

### mode

Finds the most frequent number.

#### Params

* `numbers` (table): List of numbers.

#### Returns

* `number|nil`: Mode value or `nil` if no unique mode.

#### Example

```lua
local result = maths.mode({1,2,2,3}) -- 2
```

---

### standard_deviation

Calculates standard deviation of values.

#### Params

* `numbers` (table): List of numbers.

#### Returns

* `number`: Standard deviation.

#### Example

```lua
local sd = maths.standard_deviation({2, 4, 4, 4, 5, 5, 7, 9}) -- ~2
```

---

### linear_regression

Computes slope and intercept of a best-fit line.

#### Params

* `points` (table): List of `{x=, y=}` pairs.

#### Returns

* `table`: `{ slope = number, intercept = number }`

#### Example

```lua
local result = maths.linear_regression({
    {x=1, y=2},
    {x=2, y=3},
    {x=3, y=5},
})
-- result = { slope = 1.5, intercept = 0.333... }
```

---

### weighted_choice

Chooses an item from a weighted map.

#### Params

* `map` (table): Key/value map with weights.

#### Returns

* `any|nil`: The selected key or nil.

#### Example

```lua
local choice = maths.weighted_choice({
    apple = 1,
    banana = 5,
    orange = 3
})
```

---

### random_between

Generates a float between two values.

#### Params

* `min` (number): Minimum value.
* `max` (number): Maximum value.

#### Returns

* `number`: Random float.

#### Example

```lua
local val = maths.random_between(10, 20)
```
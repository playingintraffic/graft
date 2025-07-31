# Timestamps

Cross-platform utility for working with dates, times, durations, and UNIX timestamps.  
Supports formatting, arithmetic, and conversion between raw and readable values.

---

## Shared Functions

### get_current_time

Returns the current date and time as a formatted string (`YYYY-MM-DD HH:MM:SS`).

#### Returns

* `string`: Current time.

#### Example

```lua
local now = timestamps.get_current_time() -- "2025-07-31 03:15:22"
```

---

### get_unix_ms

Returns the current UNIX timestamp in **milliseconds**.

#### Returns

* `number`: Timestamp in milliseconds.

#### Example

```lua
local ms = timestamps.get_unix_ms() -- 1722412521000
```

---

### format_duration

Formats a millisecond duration into minutes and seconds.

#### Params

* `ms` (number): Duration in milliseconds.

#### Returns

* `string`: Duration in `"Xm Ys"` format.

#### Example

```lua
local label = timestamps.format_duration(92345) -- "1m 32s"
```

---

## Client Functions

### get_timestamp

Gets the current UNIX timestamp and its formatted version.

#### Returns

* `table`:

  * `timestamp` (number)
  * `formatted` (string)

#### Example

```lua
local t = timestamps.get_timestamp()
-- t.timestamp = 1722412521
-- t.formatted = "2025-07-31 03:15:21"
```

---

### convert_timestamp

Converts a UNIX timestamp to readable formats.

#### Params

* `timestamp` (number): UNIX timestamp (seconds).

#### Returns

* `table`:

  * `date` (string): `"YYYY-MM-DD"`
  * `time` (string): `"HH:MM:SS"`
  * `both` (string): `"YYYY-MM-DD HH:MM:SS"`

#### Example

```lua
local formatted = timestamps.convert_timestamp(1722412521)
-- { date = "2025-07-31", time = "03:15:21", both = "2025-07-31 03:15:21" }
```

---

### convert_timestamp_ms

Same as `convert_timestamp` but for milliseconds input.

#### Params

* `timestamp_ms` (number): UNIX timestamp in milliseconds.

#### Returns

* `table`: Same as above.

#### Example

```lua
local data = timestamps.convert_timestamp_ms(1722412521000)
```

---

### get_current_date_time

Returns full current time breakdown.

#### Returns

* `table`:

  * `timestamp` (number): UNIX time
  * `date` (string): `"YYYY-MM-DD"`
  * `time` (string): `"HH:MM:SS"`
  * `both` (string): `"YYYY-MM-DD HH:MM:SS"`

#### Example

```lua
local now = timestamps.get_current_date_time()
```

---

### add_days_to_date

Adds a number of days to a given date string.

#### Params

* `date` (string): Date in `"YYYY-MM-DD"` format.
* `days` (number): Number of days to add.

#### Returns

* `string`: New date string.

#### Example

```lua
local future = timestamps.add_days_to_date("2025-07-31", 7)
-- "2025-08-07"
```

---

### date_difference

Calculates how many days between two dates.

#### Params

* `start_date` (string): First date in `"YYYY-MM-DD"` format.
* `end_date` (string): Second date.

#### Returns

* `table`:

  * `days` (number): Absolute difference in days.

#### Example

```lua
local diff = timestamps.date_difference("2025-07-01", "2025-07-31")
-- diff.days = 30
```
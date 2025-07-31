# Strings

Extra utility functions for working with strings, complementing Lua’s native `string` library.  
Includes formatting, trimming, casing, and basic checks.

---

## Functions

### capitalize

Capitalizes the first letter of each word in the input string.

#### Params

* `str` (string): The string to capitalize.

#### Returns

* `string`: Capitalized version of the string.

#### Example

```lua
local name = strings.capitalize("john doe") -- "John Doe"
```

---

### random_string

Generates a random alphanumeric string of a given length.

#### Params

* `length` (number): The length of the output string.

#### Returns

* `string`: The randomly generated string.

#### Example

```lua
local token = strings.random_string(10) -- e.g., "A8b39ZfLk1"
```

---

### split

Splits a string into parts using a delimiter.

#### Params

* `str` (string): The string to split.
* `delimiter` (string): Delimiter to split on.

#### Returns

* `table`: Table of split segments.

#### Example

```lua
local parts = strings.split("one,two,three", ",")
-- parts = { "one", "two", "three" }
```

---

### trim

Removes leading and trailing whitespace from a string.

#### Params

* `str` (string): The string to trim.

#### Returns

* `string`: Trimmed string.

#### Example

```lua
local cleaned = strings.trim("  hello world  ") -- "hello world"
```

---

### format_snake_case

Converts `snake_case` into a readable format.

#### Params

* `str` (string): Snake_case string (e.g., `"player_name"`).
* `case_type` (string): `"normal"` (default), `"title"`, or `"upper"`.

#### Returns

* `string`: Formatted string with spaces.

#### Example

```lua
strings.format_snake_case("hello_world") -- "hello world"
strings.format_snake_case("hello_world", "title") -- "Hello World"
strings.format_snake_case("hello_world", "upper") -- "HELLO WORLD"
```

---

### starts_with

Checks if a string starts with a given prefix.

#### Params

* `str` (string): The full string.
* `start` (string): The starting substring.

#### Returns

* `boolean`: True if it starts with the given prefix.

#### Example

```lua
strings.starts_with("foobar", "foo") -- true
```

---

### ends_with

Checks if a string ends with a given suffix.

#### Params

* `str` (string): The full string.
* `ending` (string): The ending substring.

#### Returns

* `boolean`: True if it ends with the given suffix.

#### Example

```lua
strings.ends_with("foobar", "bar") -- true
```
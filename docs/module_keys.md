# Keys

Provides a static key lookup table and helper functions to simplify working with key codes.
> Saves devs from needing to memorize or hardcode values like `38` for `E`, `289` for `F2`, etc.

---

## Key Lookup

### get_key

Returns the key code for a given key name.

#### Params

* `key_name` (string): The name of the key (e.g. `"e"`, `"f2"`, `"numpad1"`).

#### Returns

* `number`: The key code, or `nil` if not found.

#### Example

```lua
local key = keys.get_key("e") -- returns 46
```

---

### get_key_name

Returns the key name for a given key code.

#### Params

* `key_code` (number): The code of the key (e.g. `46`, `289`, `24`).

#### Returns

* `string`: The key name, or `nil` if not found.

#### Example

```lua
local name = keys.get_key_name(289) -- returns "f2"
```

---

### key_exists

Checks if a given key name exists in the static key list.

#### Params

* `key_name` (string): The key name to check.

#### Returns

* `boolean`: True if the key exists, false otherwise.

#### Example

```lua
if keys.key_exists("e") then
    print("Valid key!")
end
```

---

### get_keys

Returns the full key list as a table.

#### Returns

* `table`: A table of all key name → key code pairs.

#### Example

```lua
local all_keys = keys.get_keys()
print(all_keys["tab"]) -- returns 37
```

---

### print_key_list

Prints all available keys and their codes to the console.
Useful for debugging or key discovery.

#### Example

```lua
keys.print_key_list()
```
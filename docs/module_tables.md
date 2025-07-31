# Tables

Custom table utility functions that extend Lua's built-in `table` library.  
Includes helpers for deep copying, merging, comparison, and searching.

---

## Functions

### print_table

Recursively prints the contents of a table to the console with optional indentation.

#### Params

* `t` (table): The table to print.
* `indent` (string|nil): Optional indentation string (used for nested levels).

#### Returns

* `nil`

#### Example

```lua
tables.print_table({
    name = "John",
    stats = { health = 100, armor = 50 }
})
```

---

### table_contains

Checks if a table (including nested tables) contains a specific value.

#### Params

* `tbl` (table): Table to search through.
* `val` (any): Value to search for.

#### Returns

* `boolean`: True if the value was found.

#### Example

```lua
if tables.table_contains({ 1, 2, { 3, 4 } }, 3) then
    print("Found it")
end
```

---

### deep_copy

Creates a deep copy of a table, including nested tables and metatables.

#### Params

* `t` (table): Table to copy.

#### Returns

* `table`: A new, independent copy of the table.

#### Example

```lua
local clone = tables.deep_copy(my_table)
```

---

### deep_compare

Compares two tables deeply (including nested keys) for equality.

#### Params

* `t1` (table): First table.
* `t2` (table): Second table.

#### Returns

* `boolean`: True if the tables are deeply equal.

#### Example

```lua
if tables.deep_compare({ a = 1 }, { a = 1 }) then
    print("They match")
end
```

---

### deep_merge

Merges table `b` into table `a` recursively, without mutating the originals.
Useful for layering config overrides or traits.

#### Params

* `a` (table): Base/default values.
* `b` (table): Overrides or additions.

#### Returns

* `table`: A new, deeply merged table.

#### Example

```lua
local merged = tables.deep_merge({
    stats = { health = 100, armor = 0 },
    name = "Unknown"
}, {
    stats = { armor = 50 }
})
-- Result: { stats = { health = 100, armor = 50 }, name = "Unknown" }
```
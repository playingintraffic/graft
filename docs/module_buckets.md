# Buckets

Defines spawn zones, restrictions, and population control using FiveM routing buckets.

## Server Functions

### get_bucket

Returns the full bucket config for a given ID.

#### Params

* `id` (string): The bucket ID.

#### Returns

* `table|nil`: The bucket config if found.

```lua
buckets.get_bucket("main")
```

---

### get_bucket_by_label

Finds the bucket config that matches a label (case-insensitive).

#### Params

* `label` (string): The display label to search for.

#### Returns

* `table|nil`: The matching bucket config if found.

```lua
buckets.get_bucket_by_label("Main World")
```

---

### get_bucket_spawn

Returns the spawn location for a given bucket ID.

#### Params

* `id` (string): The bucket ID.

#### Returns

* `vector4|nil`: Spawn coordinates or nil.

```lua
buckets.get_bucket_spawn("main")
```

---

### get_bucket_respawn

Returns the respawn location for a given bucket ID.

#### Params

* `id` (string): The bucket ID.

#### Returns

* `vector4|nil`: Respawn coordinates or nil.

```lua
buckets.get_bucket_respawn("main")
```

---

### is_bucket_staff_only

Checks if a given bucket is restricted to specific staff roles.

#### Params

* `id` (string): The bucket ID.
* `role` (string): The role to verify access.

#### Returns

* `boolean`: True if access is restricted.

```lua
buckets.is_bucket_staff_only("main", "user")
```

---

### is_bucket_vip_only

Checks if a given bucket is VIP-only for the player's VIP level.

#### Params

* `id` (string): The bucket ID.
* `vip_level` (number): The player's VIP tier.

#### Returns

* `boolean`: True if access is restricted.

```lua
buckets.is_bucket_vip_only("main", 1)
```

---

### apply_bucket_settings

Applies routing settings (population + lockdown mode) for all defined buckets.

```lua
buckets.apply_bucket_settings()
```
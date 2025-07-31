# Methods

Internal event hook system for validating or filtering arbitrary logic using callbacks.  
Can be used for pre-checks, extension points, or conditional cancellation logic.

---

## Server Functions

### add_method

Adds a callback to run when a specific event is triggered.

#### Params

* `on_some_event` (string): Event key to register the method under.
* `cb` (function): The callback to invoke. Should return `false` to block.
* `options` (table|nil): Optional metadata or filtering (not used internally).

#### Returns

* `number`: A unique ID used to later remove the method.

#### Example

```lua
methods.add_method("drug:can_sell", function(data)
    return data.rep >= 10
end)
```

---

### remove_method

Removes a registered method from an event.

#### Params

* `on_some_event` (string): Event name from which to remove the method.
* `id` (number): ID returned from `add_method`.

#### Returns

* `nil`

#### Example

```lua
methods.remove_method("drug:can_sell", method_id)
```

---

### trigger_method

Runs all registered methods for a given event with shared data.
Returns `false` immediately if any callback returns `false`.

#### Params

* `on_some_event` (string): Event name to trigger.
* `response` (table): Table passed to all method callbacks.

#### Returns

* `boolean`: True if all methods pass, false if any fail.

#### Example

```lua
if not methods.trigger_method("drug:can_sell", { rep = 4 }) then
    return notify("Not enough rep.")
end
```

---

## Client Functions

### add_method

Adds a callback to a client-side event.

#### Params

* `on_some_event` (string): Event key to register under.
* `cb` (function): The callback to invoke.
* `options` (table|nil): Optional metadata.

#### Returns

* `number`: Method ID for later removal.

#### Example

```lua
methods.add_method("ui:can_open", function(state)
    return not state.blocked
end)
```

---

### remove_method

Removes a method by ID from a given client event.

#### Params

* `on_some_event` (string): The event name.
* `id` (number): Method ID to remove.

#### Returns

* `nil`

#### Example

```lua
methods.remove_method("ui:can_open", ui_check_id)
```

---

### trigger_method

Triggers all client methods for a given event, stopping on first `false`.

#### Params

* `on_some_event` (string): Event key to trigger.
* `response` (table): Data passed to each callback.

#### Returns

* `boolean`: True if all methods returned true.

#### Example

```lua
if not methods.trigger_method("ui:can_open", { blocked = false }) then
    return notify("UI is currently blocked.")
end
```
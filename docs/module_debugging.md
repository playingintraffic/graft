# Debugging

Basic debug tools for use within GRAFT.
Provides log level control and conditional wait support.

## Shared Functions

### log

Prints a color-coded debug message to the console, if debugging is enabled.

#### Params

* `level` *(string)*: One of `debug`, `info`, `success`, `warn`, `error`, `critical`, `dev`
* `message` *(string)*: The message to log (should already be formatted).

#### Example

```lua
debugging.log("info", "GRAFT initialized successfully.")
debugging.log("error", "Missing dependency: lib.modules.bridge")
```

---

### wait_for

Waits until a condition is met or a timeout is reached.

#### Params

* `fn` *(function)*: A function that returns `true` to stop waiting.
* `timeout` *(number, optional)*: Max time in seconds to wait. Default: `5`.
* `interval` *(number, optional)*: Check interval in milliseconds. Default: `100`.

#### Returns

* `boolean`: Returns `true` if the condition was met, `false` if timed out.

#### Example

```lua
local success = debugging.wait_for(function()
  return DoesEntityExist(entity)
end, 10, 250)

if not success then
  debugging.log("warn", "Entity never spawned in time.")
end
```
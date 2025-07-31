# Notify Bridge

**Supported Notifications:** `boii_ui`, `pluck`, `ox_lib`, `okokNotify`, `esx`, `qb`

## Server Functions

### send

Send a notification to a specific player.

#### Params

* `source` *(number)*: Player source ID.
* `options` *(table)*: Notification options.
  * `type` *(string)*: Type of notification (`info`, `error`, etc).
  * `message` *(string)*: Main message text.
  * `header` *(string, optional)*: Optional header/title.
  * `duration` *(number, optional)*: Duration in milliseconds.

#### Returns

* `boolean`: Returns `false` if `source` or required options are missing.

```lua
bridge.send(source, {
  type = "info",
  message = "Welcome to the server",
  header = "Login",
  duration = 5000
})
```

---

## Client Functions

### send

Send a notification from client context.

#### Params

* `options` *(table)*: Notification options.
  * `type` *(string)*: Type of notification (`info`, `error`, etc).
  * `message` *(string)*: Main message text.
  * `header` *(string, optional)*: Optional header/title.
  * `duration` *(number, optional)*: Duration in milliseconds.

#### Returns

* `boolean`: Returns `false` if required options are missing.

```lua
bridge.send({
  type = "error",
  message = "You don’t have access",
  header = "Access Denied",
  duration = 3000
})
```
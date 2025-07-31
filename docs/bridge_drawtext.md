# DrawText UI Bridge

**Supported DrawText UI's:** `boii_ui`, `pluck`, `okokTextUI`, `esx`, `qb`, `ox_lib`

## Client Functions

### show
Displays a drawtext message using the selected UI bridge.

#### Params
* `options` *(table)*: Drawtext options.
    * `message` *(string)*: The message to show. **(Required)**
    * `header` *(string, optional)*: Title shown above the message.
    * `icon` *(string, optional)*: FontAwesome icon class to display.

#### Returns
* `boolean`: Returns `false` if `message` is missing.

```lua
bridge.show({
  header = "INFO",
  message = "Press [E] to interact",
  icon = "fa-solid fa-hand"
})
```

---

### hide

Hides any currently visible drawtext message.

```lua
bridge.hide()
```
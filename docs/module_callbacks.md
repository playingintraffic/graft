# Callbacks

A lightweight callback system included in GRAFT, providing an alternative to framework-specific callback logic.

## Server Functions

### register_callback

Registers a server-side callback function that can be triggered by the client.

#### Params

* `name` *(string)*: The unique name of the callback event.
* `cb` *(function)*: The function to execute when the callback is triggered.

#### Example

```lua
callbacks.register_callback("get_player_data", function(source, data, cb)
  local player_data = { id = source, job = "police" }
  cb(player_data)
end)
```

---

## Client Functions

### trigger_callback

Triggers a registered server-side callback and handles the response client-side.

#### Params

* `name` *(string)*: The name of the server callback to invoke.
* `data` *(table)*: Data to send with the request.
* `cb` *(function)*: Function that handles the server's response.

#### Example

```lua
callbacks.trigger_callback("get_player_data", {}, function(response)
  print("Player Job:", response.job)
end)
```
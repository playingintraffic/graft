# Commands

A standalone, permissioned command system included in GRAFT.
Built to allow easy command registration with rank restrictions and chat suggestions.

> **Requires:** `graft_users` SQL table for permission resolution.

## Server Functions

### register_command

Registers a command with optional permission restriction and optional autocomplete chat suggestion.

#### Params

* `command` *(string)*: The command name (without `/`).
* `required_rank` *(string or table or nil)*: Single rank or list of allowed ranks. Use `nil` to allow all users.
* `help` *(string)*: Help text to show in suggestion (optional).
* `params` *(table)*: Parameter definitions for chat suggestion (optional).
* `handler` *(function)*: The function to run when the command is executed.

#### Example

```lua
commands.register_command("fixcar", "admin", "Fix nearby vehicle", {}, function(source, args, raw)
    -- repair logic
end)
```

---

## Client Functions

### get_command_suggestions

Requests the server to resend the list of chat suggestions.
Use this on player load or UI open if needed.

```lua
commands.get_command_suggestions()
```

---

## Permission Handling

Ranks are pulled from the `graft_users` table.
You can assign ranks using your own admin panel or SQL manually.

### Available Ranks

* `user`
* `trusted`
* `support`
* `moderator`
* `admin`
* `developer`
* `owner`

You can also pass multiple ranks like this:

```lua
commands.register_command("announce", {"admin", "developer", "owner"}, "Send a global message", {}, function(src, args, raw)
    -- announce logic
end)
```
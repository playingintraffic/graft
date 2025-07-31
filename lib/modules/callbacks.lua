--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module callbacks
--- Standalone callback registration system.
--- This can be used instead of having to write multiple different callbacks for each framework.

local callbacks = {}

--- @section Import Modules

local debugging <const> = graft.get("lib.modules.debugging")

--- @section Tables

local stored_callbacks = {}

if graft.is_server then

    --- Registers a server-side callback.
    --- @param name string: The name of the callback event.
    --- @param cb function: The callback function to be executed.
    function callbacks.register_callback(name, cb)
        if not name or not cb then debugging.log("error", ("Failed to register callback: invalid name or function. name: %s"):format(name or "nil")) return end
        if stored_callbacks[name] then debugging.log("warning", ("Overwriting existing callback: %s"):format(name)) end
        stored_callbacks[name] = cb
    end

else

    --- Triggers a server-side callback from the client.
    --- @param name string: Callback name to trigger
    --- @param data table: Data to send with the callback
    --- @param cb function: Function to handle the servers response
    function callbacks.trigger_callback(name, data, cb)
        local cb_id = math.random(1, 1000000)
        stored_callbacks[cb_id] = cb
        TriggerServerEvent("graft:sv:trigger_callback", name, data, cb_id)
    end

end

return callbacks

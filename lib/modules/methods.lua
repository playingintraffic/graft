--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module methods
--- Handles adding additional "methods" to be validated against.
--- These can be used for basically anything.

local methods = {}

if graft.is_server then

    local server_methods = {}

    --- Adds a method callback to a specific server-side event.
    --- @param on_some_event string: The event to hook into.
    --- @param cb function: The callback function.
    --- @param options table|nil: Optional filtering options.
    --- @return number: ID of the method (for later removal).
    function methods.add_method(on_some_event, cb, options)
        if not server_methods[on_some_event] then server_methods[on_some_event] = {} end
        local id = #server_methods[on_some_event] + 1
        server_methods[on_some_event][id] = { callback = cb, options = options }
        return id
    end

    --- Removes a method by ID for a given event.
    --- @param on_some_event string: Event name to remove from.
    --- @param id number: The method ID to remove.
    function methods.remove_method(on_some_event, id)
        if server_methods[on_some_event] then server_methods[on_some_event][id] = nil end
    end

    --- Triggers all methods for an event, stopping if any return false.
    --- @param on_some_event string: Event name to trigger.
    --- @param response table: Table passed to all method callbacks.
    --- @return boolean: True if no method blocked, false otherwise.
    function methods.trigger_method(on_some_event, response)
        local list = server_methods[on_some_event]
        if not list then return true end
        for _, method in pairs(list) do
            if method.callback(response) == false then return false end
        end
        return true
    end

else

    local client_methods = {}

    --- Adds a method callback to a specific client-side event.
    --- @param on_some_event string: The event to hook into.
    --- @param cb function: The callback function.
    --- @param options table|nil: Optional filtering options.
    --- @return number: ID of the method (for later removal).
    function methods.add_method(on_some_event, cb, options)
        if not client_methods[on_some_event] then client_methods[on_some_event] = {} end
        local id = #client_methods[on_some_event] + 1
        client_methods[on_some_event][id] = { callback = cb, options = options }
        return id
    end

    --- Removes a method by ID for a given event.
    --- @param on_some_event string: Event name to remove from.
    --- @param id number: The method ID to remove.
    function methods.remove_method(on_some_event, id)
        if client_methods[on_some_event] then client_methods[on_some_event][id] = nil end
    end

    --- Triggers all methods for an event, stopping if any return false.
    --- @param on_some_event string: Event name to trigger.
    --- @param response table: Table passed to all method callbacks.
    --- @return boolean: True if no method blocked, false otherwise.
    function methods.trigger_method(on_some_event, response)
        local list = client_methods[on_some_event]
        if not list then return true end
        for _, method in pairs(list) do
            if method.callback(response) == false then return false end
        end
        return true
    end
end

return methods
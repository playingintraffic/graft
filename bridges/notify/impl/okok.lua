--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don’t be that guy…
]]

local bridge = {}

if graft.is_server then

    --- Send notification to a specific client via okokNotify:Alert.
    --- @param source number Player source ID.
    --- @param options table Notification options (type, message, header, duration).
    function bridge.send(source, options)
        if not source or not options or not (options.type and options.message) then return false end
        TriggerClientEvent("okokNotify:Alert", source, options.header, options.message, options.type, options.duration)
    end

else

    --- Send notification via okokNotify:Alert.
    --- @param options table Notification options (type, message, header, duration).
    function bridge.send(options)
        if not options or not options.type or not options.message then return false end
        TriggerEvent("okokNotify:Alert", options.header, options.message, options.type, options.duration)
    end

end

return bridge

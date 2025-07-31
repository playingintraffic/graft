--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

if graft.drawtext_ui ~= "standalone" then return end

local bridge = {}

if not graft.is_server then

    --- Show drawtext by emitting the generic boii_utils event.
    --- @param options table Drawtext options (header, message, icon).
    function bridge.show(options)
        if not options or not options.message then return false end
        print("No default drawtext UI replacement is implemented yet..")
    end

    --- Hide drawtext by emitting the generic boii_utils event.
    function bridge.hide()
        print("No default drawtext UI replacement is implemented yet..")
    end

end

return bridge
--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don’t be that guy…
]]

local bridge = {}

if not graft.is_server then

    --- Show drawtext via boii_ui export.
    --- @param options table Drawtext options (header, message, icon).
    function bridge.show(options)
        if not options or not options.message then return false end
        exports.boii_ui:show_drawtext(options.header, options.message, options.icon)
    end

    --- Hide drawtext via boii_ui export.
    function bridge.hide()
        exports.boii_ui:hide_drawtext()
    end

end

return bridge

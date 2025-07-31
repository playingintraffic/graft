--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don’t be that guy…
]]

local bridge = {}

if not graft.is_server then
    --- Show drawtext via ox_ui lib.
    --- @param options table Drawtext options (must contain message, may contain icon).
    function bridge.show(options)
        if not options or not options.message then return false end
        exports.ox_lib:showTextUI(options.message, { icon = options.icon })
    end

    --- Hide drawtext via ox_ui lib.
    function bridge.hide()
        exports.ox_lib:hideTextUI()
    end

end

return bridge

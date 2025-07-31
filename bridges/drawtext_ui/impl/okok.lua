--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don’t be that guy…
]]

local bridge = {}

if not graft.is_server then

    --- Show drawtext via okokTextUI.
    --- @param options table Drawtext options (must contain message).
    function bridge.show(options)
        if not options or not options.message then return false end
        exports.okokTextUI:Open(options.message, "lightgrey", "left", true)
    end

    --- Hide drawtext via okokTextUI.
    function bridge.hide()
        exports.okokTextUI:Close()
    end

end

return bridge

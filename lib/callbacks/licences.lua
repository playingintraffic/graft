--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

if not graft.is_server then return end

local callbacks <const> = graft.get("lib.modules.callbacks")
local licences <const> = graft.get("lib.modules.licences")

callbacks.register_callback("graft:sv:get_licences", function(source, data, cb)
    local utils_licences = licences.get_licences(source)
    if utils_licences then
        cb({ success = true, licences = utils_licences })
    else
        cb({ success = false, })
    end
end)
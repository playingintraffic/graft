--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

local res = graft.notify or "standalone"
local path = "bridges.notify.impl." .. res
local success, m = pcall(graft.get, path)

if not success or type(m) ~= "table" then
    print(("^1[graft]^7 Failed to load notify bridge: %s"):format(res))
    return {}
end

return m
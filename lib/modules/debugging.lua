--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module debugging
--- Basic debug logging with coloured output and levels.

--- @section Import Modules

local timestamps <const> = graft.get("lib.modules.timestamps")

local debugging = {}

--- @section Debug Colours

--- Prints a formatted debug message to the console.
--- @param level string: One of "debug", "info", "success", "warn", "error", "critical", "dev".
--- @param message string: Pre-formatted message to display.
function debugging.log(level, message)
    if not graft.debug_enabled then return end

    local clr = graft.debug_colours[level] or "^7"
    local time = timestamps.get_current_time()

    print(("%s[%s] [graft] [%s]:^7 %s"):format(clr, time, level:upper(), message))
end

--- Waits until a given function returns true or a timeout is reached.
--- @param fn function: The condition function to evaluate.
--- @param timeout number|nil: Time to wait in seconds (default 5).
--- @param interval number|nil: Check interval in ms (default 100).
--- @return boolean: True if condition met, false if timed out.
function debugging.wait_for(fn, timeout, interval)
    timeout = timeout or 5
    interval = interval or 100

    local waited = 0
    while not fn() do
        if waited >= timeout * 1000 then return false end
        Wait(interval)
        waited = waited + interval
    end

    return true
end
return debugging

--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @section Module

local timestamps = {}

--- Returns the current timestamp as a formatted string.
--- @return string: Formatted time (YYYY-MM-DD HH:MM:SS)
function timestamps.get_current_time()
    if graft.is_server then return os.date("%Y-%m-%d %H:%M:%S") end
    if GetLocalTime then
        local y, m, d, h, min, s = GetLocalTime()
        return string.format("%04d-%02d-%02d %02d:%02d:%02d", y, m, d, h, min, s)
    end
    return "0000-00-00 00:00:00"
end

function timestamps.get_unix_ms()
    if graft.is_server then
        return os.time() * 1000
    else
        return GetCloudTimeAsInt() * 1000
    end
end

function timestamps.format_duration(ms)
    local total_seconds = math.floor(ms / 1000)
    local minutes = math.floor(total_seconds / 60)
    local seconds = total_seconds % 60
    return ("%dm %ds"):format(minutes, seconds)
end

if not graft.is_server then

    --- Gets the current timestamp and its formatted version.
    --- @return table: A table containing raw timestamp and formatted date-time string.
    function timestamps.get_timestamp()
        local ts = os.time()

        return { 
            timestamp = ts, 
            formatted = os.date("%Y-%m-%d %H:%M:%S", ts)
        }
    end

    --- Converts a UNIX timestamp to a human-readable date and time format.
    --- @param timestamp number: A UNIX timestamp.
    --- @return table: A table containing date, time, and formatted date-time string based on the input timestamp.
    function timestamps.convert_timestamp(timestamp)
        return { 
            date = os.date("%Y-%m-%d", timestamp), 
            time = os.date("%H:%M:%S", timestamp), 
            both = os.date("%Y-%m-%d %H:%M:%S", timestamp) 
        }
    end

    --- Gets the current date and time.
    --- @return table: A table containing the current date, time, timestamp, and formatted date-time string.
    function timestamps.get_current_date_time()
        local ts = os.time()

        return { 
            timestamp = ts,
            date = os.date("%Y-%m-%d", ts), 
            time = os.date("%H:%M:%S", ts), 
            both = os.date("%Y-%m-%d %H:%M:%S", ts)
        }
    end

    --- Adds a specified number of days to a given date.
    --- @param date string: The original date in "YYYY-MM-DD" format.
    --- @param days number: The number of days to add.
    --- @return string: The new date after adding the specified number of days.
    function timestamps.add_days_to_date(date, days)
        local pattern = "(%d+)-(%d+)-(%d+)"
        local year, month, day = date:match(pattern)
        local time = os.time{year=year, month=month, day=day}
        local new_time = time + (days * 24 * 60 * 60)

        return os.date("%Y-%m-%d", new_time)
    end

    --- Calculates the difference in days between two dates.
    --- @param start_date string: The start date in "YYYY-MM-DD" format.
    --- @param end_date string: The end date in "YYYY-MM-DD" format.
    --- @return table: A table containing the difference in days between the two dates.
    function timestamps.date_difference(start_date, end_date)
        local pattern = "(%d+)-(%d+)-(%d+)"
        local start_year, start_month, start_day = start_date:match(pattern)
        local end_year, end_month, end_day = end_date:match(pattern)
        local start = os.time{year=start_year, month=start_month, day=start_day}
        local finish = os.time{year=end_year, month=end_month, day=end_day}

        return { days = math.abs(os.difftime(finish, start) / (24 * 60 * 60)) }
    end

    --- Converts a UNIX timestamp in milliseconds to a human-readable date-time format.
    --- @param timestamp_ms number: A UNIX timestamp in milliseconds.
    --- @return table: A table containing date, time, and both date-time string based on the input timestamp in milliseconds.
    function timestamps.convert_timestamp_ms(timestamp_ms)
        local timestamp_seconds = math.floor(timestamp_ms / 1000)
        
        return { 
            date = os.date("%Y-%m-%d", timestamp_seconds), 
            time = os.date("%H:%M:%S", timestamp_seconds), 
            both = os.date("%Y-%m-%d %H:%M:%S", timestamp_seconds) 
        }
    end
end

return timestamps

--[[
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module strings
--- Handles a small amount of custom functions not covered by Lua's `string.` API.

local strings = {}

--- Capitalizes the first letter of each word in a string.
--- @param str string: The string to capitalize.
--- @return string: The capitalized string.
function strings.capitalize(str)
    return string.gsub(str, "(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
end

exports("capitalize", strings.capitalize)

--- Generates a random string of a specified length.
--- @param length number: The length of the random string.
--- @return string: The random string.
function strings.random_string(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = {}

    for _ = 1, length do
        local r_char = chars:sub(math.random(1, #chars), math.random(1, #chars))
        table.insert(result, r_char)
    end

    return table.concat(result)
end

exports("random_string", strings.random_string)

--- Splits a string into a table based on a given delimiter.
--- @param str string: The string to split.
--- @param delimiter string: The delimiter to split by.
--- @return table: A table of split segments.
function strings.split(str, delimiter)
    local result = {}

    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        result[#result + 1] = match
    end

    return result
end

exports("split", strings.split)

--- Trims whitespace from the beginning and end of a string.
--- @param str string: The string to trim.
--- @return string: The trimmed string.
function strings.trim(str)
    return str:match("^%s*(.-)%s*$")
end

exports("trim", strings.trim)

--- Converts a snake_case string to a readable string.
--- @param str string: The snake_case string.
--- @param case_type string: The output casing format ("normal", "title", or "upper").
--- @return string: The formatted output string.
function strings.format_snake_case(str, case_type)
    local parts = {}
    for word in string.gmatch(str, "[^_]+") do
        table.insert(parts, word)
    end

    if case_type == "title" then
        for i = 1, #parts do
            parts[i] = parts[i]:sub(1,1):upper() .. parts[i]:sub(2):lower()
        end
    elseif case_type == "upper" then
        for i = 1, #parts do
            parts[i] = parts[i]:upper()
        end
    end

    return table.concat(parts, " ")
end

exports("format_snake_case", strings.format_snake_case)

--- Checks if a string starts with a given substring.
--- @param str string: The full string to check.
--- @param start string: The starting substring.
--- @return boolean: True if the string starts with the given substring.
function strings.starts_with(str, start)
    return str:sub(1, #start) == start
end

exports("starts_with", strings.starts_with)

--- Checks if a string ends with a given substring.
--- @param str string: The full string to check.
--- @param ending string: The ending substring.
--- @return boolean: True if the string ends with the given substring.
function strings.ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

exports("ends_with", strings.ends_with)

return strings

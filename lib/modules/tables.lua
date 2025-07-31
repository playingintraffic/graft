--[[
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module tables
--- Handles a small amount of custom functions not covered by Lua's `table.` API.

local tables = {}

--- Prints the contents of a table to the console. Useful for debugging.
--- @param t table: The table to print.
--- @param indent string|nil: The indentation level for nested tables.
function tables.print_table(t, indent)
    indent = indent or ''
    for k, v in pairs(t) do
        if type(v) == 'table' then
            print(indent .. k .. ':')
            tables.print_table(v, indent .. '  ')
        else
            local value_str = type(v) == "boolean" and tostring(v) or v
            print(indent .. k .. ': ' .. value_str)
        end
    end
end

--- Checks if a table contains a specific value.
--- @param tbl table: The table to search through.
--- @param val any: The value to search for in the table.
--- @return boolean: True if the value was found, false otherwise.
function tables.table_contains(tbl, val)
    for _, value in pairs(tbl) do
        if value == val then
            return true
        elseif type(value) == "table" then
            if tables.table_contains(value, val) then
                return true
            end
        end
    end
    return false
end

--- Creates a deep copy of a table, ensuring changes to the copy won't affect the original table.
--- @param t table: The table to copy.
--- @return table: A deep copy of the table.
function tables.deep_copy(t)
    local orig_type = type(t)
    local copy

    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, t, nil do
            copy[tables.deep_copy(orig_key)] = tables.deep_copy(orig_value)
        end
        setmetatable(copy, tables.deep_copy(getmetatable(t)))
    else
        copy = t
    end

    return copy
end

--- Compares two nested tables to check if they are equal.
--- @param t1 table: The first table.
--- @param t2 table: The second table.
--- @return boolean: True if the tables are equal, false otherwise.
function tables.deep_compare(t1, t2)
    if t1 == t2 then return true end
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for k, v in pairs(t1) do
        if not tables.compare(v, t2[k]) then return false end
    end

    for k in pairs(t2) do
        if t1[k] == nil then return false end
    end

    return true
end

--- Deeply merges two tables (b into a), without mutating original tables.
--- @param a table: The base table (usually defaults).
--- @param b table: The override table (e.g., strain).
--- @return table: A new table containing the merged result.
function tables.deep_merge(a, b)
    local result = tables.deep_copy(a)

    for k, v in pairs(b) do
        if type(v) == "table" and type(result[k]) == "table" then
            local is_array = (#v > 0 or #result[k] > 0)
            if not is_array then
                result[k] = tables.deep_merge(result[k], v)
            else
                result[k] = v
            end
        else
            result[k] = v
        end
    end

    return result
end


return tables

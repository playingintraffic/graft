--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module profanity
--- Handles basic profanity filtering.
--- You should build out the `bad_word` and `replace_words` accordingly to what you want to catch.
--- If you offended by any of the words in the list.. it is what it is.. they need to be somewhere for them to be caught :D..

local profanity = {}

--- Basic leetspeak conversions
--- Should catch those weirdos trying to circumvent with l33tspeak e.g. `n1gg3r` or `f4g`
local leet_replacements = {
    ["1"] = "i",
    ["!"] = "i",
    ["3"] = "e",
    ["4"] = "a",
    ["@"] = "a",
    ["5"] = "s",
    ["$"] = "s",
    ["7"] = "t",
    ["0"] = "o",
    ["9"] = "g"
}

--- Bad words list add more as needed
local bad_words = {
    "nigger",
    "nigga",
    "fuck",
    "shit",
    "bitch",
    "cunt",
    "faggot",
    "asshole"
}

--- Optional replacements for specific words
local replace_words = {
    nigger = "my friend",
    nigga = "buddy"
}

--- @section Internal Functions

--- Converts leetspeak to normal letters
--- @param text string
--- @return string
local function normalize_leetspeak(text)
    text = text:lower()
    for k, v in pairs(leet_replacements) do
        text = text:gsub(k, v)
    end
    return text
end

--- Escapes special characters in Lua patterns
--- @param str string
--- @return string
local function escape_lua_pattern(str)
    return str:gsub("([^%w])", "%%%1")
end

--- @section API Functions

--- Check if a string contains profanity
--- @param input string
--- @return boolean
function profanity.has(input)
    if not input or input == "" then return false end
    local normalized = normalize_leetspeak(input:lower())

    for _, word in ipairs(bad_words) do
        if normalized:find(word, 1, true) then
            return true
        end
    end

    return false
end

--- Clean a string by replacing or masking profane words
--- @param input string
--- @param use_mask boolean: If true, replace with asterisks instead of replacements
--- @return string
function profanity.clean(input, use_mask)
    if not input or input == "" then return input end

    local original = input
    local cleaned = input
    local normalized = normalize_leetspeak(original:lower())

    for _, word in ipairs(bad_words) do
        local pattern = escape_lua_pattern(word)
        local replacement = use_mask and ("*" ):rep(#word) or replace_words[word] or ("*" ):rep(#word)
        cleaned = cleaned:gsub("%f[%w]" .. pattern .. "%f[%W]", replacement)
    end

    return cleaned
end

return profanity
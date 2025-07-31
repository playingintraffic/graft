--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module keys
--- Handles some general key functions and a static key list.
--- Mainly saves on needing to remember key codes..

--- @section Key List

local key_list <const> = {
    ["enter"] = 191,
    ["escape"] = 322,
    ["backspace"] = 177,
    ["tab"] = 37,
    ["arrowleft"] = 174,
    ["arrowright"] = 175,
    ["arrowup"] = 172,
    ["arrowdown"] = 173,
    ["space"] = 22,
    ["delete"] = 178,
    ["insert"] = 121,
    ["home"] = 213,
    ["end"] = 214,
    ["pageup"] = 10,
    ["pagedown"] = 11,
    ["leftcontrol"] = 36,
    ["leftshift"] = 21,
    ["leftalt"] = 19,
    ["rightcontrol"] = 70,
    ["rightshift"] = 70,
    ["rightalt"] = 70,
    ["numpad0"] = 108,
    ["numpad1"] = 117,
    ["numpad2"] = 118,
    ["numpad3"] = 60,
    ["numpad4"] = 107,
    ["numpad5"] = 110,
    ["numpad6"] = 109,
    ["numpad7"] = 117,
    ["numpad8"] = 111,
    ["numpad9"] = 112,
    ["numpad+"] = 96,
    ["numpad-"] = 97,
    ["numpadenter"] = 191,
    ["numpad."] = 108,
    ["f1"] = 288,
    ["f2"] = 289,
    ["f3"] = 170,
    ["f4"] = 168,
    ["f5"] = 166,
    ["f6"] = 167,
    ["f7"] = 168,
    ["f8"] = 169,
    ["f9"] = 56,
    ["f10"] = 57,
    ["a"] = 34,
    ["b"] = 29,
    ["c"] = 26,
    ["d"] = 30,
    ["e"] = 46,
    ["f"] = 49,
    ["g"] = 47,
    ["h"] = 74,
    ["i"] = 27,
    ["j"] = 36,
    ["k"] = 311,
    ["l"] = 182,
    ["m"] = 244,
    ["n"] = 249,
    ["o"] = 39,
    ["p"] = 199,
    ["q"] = 44,
    ["r"] = 45,
    ["s"] = 33,
    ["t"] = 245,
    ["u"] = 303,
    ["v"] = 0,
    ["w"] = 32,
    ["x"] = 73,
    ["y"] = 246,
    ["z"] = 20,
    ["mouse1"] = 24,
    ["mouse2"] = 25
}

--- @section Modules

local keys = {}

--- Retrieves the key code for a given key name.
--- @param key_name string: The name of the key.
--- @return number: The key code for the given key name, or nil if not found.
function keys.get_keys(key_name)
    return key_list
end

--- Retrieves the key code for a given key name.
--- @param key_name string: The name of the key.
--- @return number: The key code for the given key name, or nil if not found.
function keys.get_key(key_name)
    return key_list[key_name]
end

--- Retrieves the key name for a given key code.
--- @param key_code number: The code of the key.
--- @return string: The key name for the given key code, or nil if not found.
function keys.get_key_name(key_code)
    for name, code in pairs(key_list) do
        if code == key_code then
            return name
        end
    end
    return nil
end

--- Prints the list of all keys and their codes.
function keys.print_key_list()
    print("Keylist:")
    for name, code in pairs(key_list) do
        print(name, code)
    end
end

--- Checks if a key exists in the keys table.
--- @param key_name string: The name of the key to check.
--- @return boolean: True if the key exists, false otherwise.
function keys.key_exists(key_name)
    return key_list[key_name] ~= nil
end

return keys
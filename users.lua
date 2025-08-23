--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

--- @script users
--- Handles user accounts for graft.
--- These are required for command permissions, and providing standalone accounts.

--- @section Constants

--- Constants for identifier types.
local identifiers = { license = "license2", discord = "discord", ip = "ip" }

--- @section User Tables

local temp_connected_users = {}
connected_users = {}

--- @section Internal Functions

--- Check if a player is banned and handle the deferral.
--- @param user_data table: The users account data retrieved from the database.
--- @param deferrals table: The deferral object used to communicate with the client.
--- @return boolean: True if the player is banned, false otherwise.
local function is_player_banned(user_data, deferrals)
    if user_data.banned then
        deferrals.done(("You are banned. Appeal with your unique ID: %s"):format(user_data.unique_id))
        return true
    end
    return false
end

--- Update the deferral message and optionally wait for a delay.
--- @param deferrals table: The deferral object used to communicate with the client.
--- @param message string: The message to display to the player.
--- @param delay number|nil: Optional delay in milliseconds before proceeding.
local function update_deferral(deferrals, message, delay)
    if graft.deferals_updates then
        deferrals.update(message)
    end
    if delay then Wait(delay) end
end

--- @section Utility Functions

--- Retrieve player identifiers for the given source.
--- @param source number: The players source identifier.
--- @return table: A table containing the players license, discord, and ip identifiers.
function graft.get_identifiers(source)
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(id, identifiers.license) then
            identifiers.license = id
        elseif string.match(id, identifiers.discord) then
            identifiers.discord = id
        elseif string.match(id, identifiers.ip) then
            identifiers.ip = id
        end
    end
    return identifiers
end

exports("get_identifiers", graft.get_identifiers)

--- Generates a unique ID by concatenating a prefix with a randomly generated string of specified length.
--- If a JSON path is provided, it checks within the JSON structure in the specified column.
--- @param prefix A string prefix for the ID (e.g., "CAR", "MOTO").
--- @param length The length of the numeric part of the ID.
--- @param table_name The name of the database table for uniqueness check.
--- @param column_name The name of the database column for uniqueness check.
--- @param json_path (Optional) The JSON path if the ID is within a JSON structure.
--- @return A unique ID string.
function graft.generate_unique_id(prefix, length, table_name, column_name, json_path)
    local charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local id
    local function create_id()
        local new_id = prefix
        for i = 1, length do
            local random_index = math.random(1, #charset)
            new_id = new_id .. charset:sub(random_index, random_index)
        end
        return new_id
    end
    local function id_exists(new_id)
        local query
        if json_path then
            query = string.format("SELECT COUNT(*) as count FROM %s WHERE JSON_EXTRACT(%s, '$.%s') = ?", table_name, column_name, json_path)
        else
            query = string.format("SELECT COUNT(*) as count FROM %s WHERE %s = ?", table_name, column_name)
        end
        local result = MySQL.query.await(query, { new_id })
        return result and result[1] and result[1].count > 0
    end
    repeat
        id = create_id()
    until not id_exists(id)
    return id
end

exports("generate_unique_id", graft.generate_unique_id)

--- Check if a players user data exists in the database.
--- @param license string: The players license identifier.
--- @return table|nil: The user data if it exists, or nil if not found.
function graft.check_if_user_data_exists(license)
    local query = "SELECT * FROM graft_users WHERE license = ?"
    return MySQL.query.await(query, { license })
end

exports("check_if_user_data_exists", graft.check_if_user_data_exists)

--- Create a new user account in the database.
--- @param name string: The players name.
--- @param unique_id string: The generated unique ID for the player.
--- @param license string: The players license identifier.
--- @param discord string|nil: The players Discord identifier.
--- @param tokens table: The players session tokens.
--- @param ip string: The players ip address.
function graft.create_user(name, unique_id, license, discord, tokens, ip)
    local query = "INSERT INTO graft_users (unique_id, name, license, discord, tokens, ip) VALUES (?, ?, ?, ?, ?, ?)"
    MySQL.prepare.await(query, { unique_id, name, license, discord, json.encode(tokens), ip })
end

exports("create_user", graft.create_user)

--- Retrieves all connected users.
--- @return table: A list of all connected users.
function graft.get_users()
    return connected_users
end

exports("get_users", graft.get_users)

--- Retrieve user data by source ID.
--- @param source number: The players source identifier.
--- @return table|nil: The user data if found, or nil if not.
function graft.get_user(source)
    return connected_users[source] or nil
end

exports("get_user", graft.get_user)

--- Update a connected user's data in memory and persist changes to the database.
--- @param source number: The player source.
--- @param updates table: A table of key-value pairs to update.
--- @return boolean: True if successful, false if user not found.
function graft.update_user_data(source, updates)
    local user = connected_users[source]
    if not user then return false end

    for key, value in pairs(updates) do
        if user[key] ~= nil then
            user[key] = value
        end
    end

    local update_keys = {}
    local update_values = {}

    for key, value in pairs(updates) do
        table.insert(update_keys, string.format("`%s` = ?", key))
        if type(value) == "table" then
            table.insert(update_values, json.encode(value))
        else
            table.insert(update_values, value)
        end
    end

    if #update_keys == 0 then return false end

    table.insert(update_values, user.license)

    local query = string.format("UPDATE graft_users SET %s WHERE license = ?", table.concat(update_keys, ", "))
    MySQL.prepare.await(query, update_values)

    return true
end

exports("update_user_data", graft.update_user_data)

--- Ban a user by source or unique_id, with a reason and optional expiry.
--- @param input number|string: Either a source ID or a unique_id string.
--- @param banned_by string: Admin username or source performing the ban.
--- @param reason string: Reason for the ban.
--- @param duration number|nil: Optional duration in seconds (nil = permanent).
--- @return boolean: True if banned, false if not found or error.
function graft.ban_user(input, banned_by, reason, duration)
    local user = type(input) == "number" and graft.get_user(input) or nil
    local unique_id

    if user then
        unique_id = user.unique_id
    elseif type(input) == "string" then
        unique_id = input
    end

    if not unique_id then return false end

    local expires_at = duration and os.date("%Y-%m-%d %H:%M:%S", os.time() + duration) or nil

    MySQL.prepare.await("UPDATE graft_users SET banned = 1 WHERE unique_id = ?", { unique_id })

    MySQL.prepare.await([[
        INSERT INTO graft_bans (unique_id, banned_by, reason, expires_at)
        VALUES (?, ?, ?, ?)
    ]], { unique_id, banned_by or "graft", reason or "No reason provided", expires_at })

    for src, data in pairs(connected_users) do
        if data.unique_id == unique_id then
            DropPlayer(src, string.format("You have been banned.\nReason: %s", reason or "No reason provided"))
            connected_users[src] = nil
            break
        end
    end

    return true
end

exports("ban_user", graft.ban_user)

--- Unban a user by their unique ID.
--- @param unique_id string: The unique ID of the banned user.
--- @return boolean: True if unbanned, false if not found or already unbanned.
function graft.unban_user(unique_id)
    if not unique_id then return false end

    local result = MySQL.query.await("SELECT banned FROM graft_users WHERE unique_id = ?", { unique_id })
    if not result or not result[1] then return false end
    if result[1].banned == 0 then return false end

    MySQL.prepare.await("UPDATE graft_users SET banned = 0 WHERE unique_id = ?", { unique_id })

    MySQL.prepare.await([[
        UPDATE graft_bans
        SET expired = 1
        WHERE unique_id = ? AND expired = 0
        ORDER BY timestamp DESC
        LIMIT 1
    ]], { unique_id })

    return true
end

exports("unban_user", graft.unban_user)

--- @section Event Handlers

--- Handle player connection, validate identifiers, check bans, and create user data if necessary.
--- @param name string: The players name.
--- @param kick function: The function to kick the player.
--- @param deferrals table: The deferral object used to communicate with the client.
local function on_player_connect(name, kick, deferrals)
    local source = source
    local ids = graft.get_identifiers(source)
    if not ids.license then kick("No valid license found.") return end

    local unique_id = graft.generate_unique_id(graft.unique_id_prefix, graft.unique_id_chars, "graft_users", "unique_id")

    deferrals.defer()
    update_deferral(deferrals, "Checking your identifiers...", 100)

    local result = graft.check_if_user_data_exists(ids.license)
    local user_data = result and result[1]

    if user_data then
        update_deferral(deferrals, "User data found. Checking bans...", 500)

        local ban = MySQL.query.await([[
            SELECT id, reason, expires_at FROM graft_bans
            WHERE unique_id = ? AND expired = 0
            ORDER BY timestamp DESC
            LIMIT 1
        ]], { user_data.unique_id })

        local active_ban = ban and ban[1]

        if active_ban then
            if active_ban.expires_at and os.time() > os.time({ year=1970, month=1, day=1 }) then
                local expires = os.time(os.date("*t", os.time(active_ban.expires_at)))
                if os.time() > expires then
                    MySQL.prepare.await("UPDATE graft_bans SET expired = 1 WHERE id = ?", { active_ban.id })
                    MySQL.prepare.await("UPDATE graft_users SET banned = 0 WHERE unique_id = ?", { user_data.unique_id })
                    print(("[GRAFT] Auto-expired ban for %s"):format(user_data.unique_id))
                else
                    deferrals.done(("You are banned until %s.\nReason: %s"):format(active_ban.expires_at, active_ban.reason or "No reason provided"))
                    return
                end
            else
                deferrals.done(("You are permanently banned.\nReason: %s"):format(active_ban.reason or "No reason provided"))
                return
            end
        end

        update_deferral(deferrals, "Welcome back!", 500)
        temp_connected_users[ids.license] = user_data
    else
        update_deferral(deferrals, "Creating new user...", 500)
        graft.create_user(name, unique_id, ids.license, ids.discord, GetPlayerTokens(source), ids.ip)

        temp_connected_users[ids.license] = {
            name = name,
            unique_id = unique_id,
            rank = "user",
            username = nil,
            vip = false,
            priority = 0,
            characters = 2,
            license = ids.license,
            discord = ids.discord,
            tokens = json.encode(GetPlayerTokens(source)),
            ip = ids.ip,
            banned = false,
            muted = 0,
            deleted = 0,
            notes = nil,
            settings = "{}",
            last_login = os.date("%Y-%m-%d %H:%M:%S"),
            created = os.date("%Y-%m-%d %H:%M:%S")
        }
    end

    update_deferral(deferrals, "Welcome to the community!", 500)
    deferrals.done()
end

AddEventHandler("playerConnecting", on_player_connect)

--- Moves player from temp to connected on join.
local function on_player_joining()
    local source = source
    local ids = graft.get_identifiers(source)
    if ids.license and temp_connected_users[ids.license] then
        connected_users[source] = temp_connected_users[ids.license]
        temp_connected_users[ids.license] = nil
    else
        print("No temp data found for license:", ids.license or "UNKNOWN")
    end
end
AddEventHandler("playerJoining", on_player_joining)

--- Handle player disconnection, removing them from all user tables.
local function on_player_drop()
    local source = source
    connected_users[source] = nil
end
AddEventHandler("playerDropped", on_player_drop)

--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @section xp
--- Standalone XP system.

local callbacks <const> = graft.get("lib.modules.callbacks")
local core <const> = graft.get("bridges.framework.loader")

--- @module XP

local xp = {}

if graft.is_server then

    local player_xp = {}

    --- Calculates required experience points for the next level.
    --- @param current_level number: The current level of the skill.
    --- @param first_level_xp number: The experience points required for the first level.
    --- @param growth_factor number: The growth factor for experience points.
    --- @return number: The required XP for the next level.
    function xp.calculate_required_xp(current_level, first_level_xp, growth_factor)
        return math.floor(first_level_xp * (growth_factor ^ (current_level - 1)))
    end

    --- Inserts a new skill entry for a player if it doesn"t already exist.
    --- @param source number: The player source ID.
    --- @param xp_id string: The XP ID.
    --- @param xp_type string: The XP type.
    --- @return boolean|number: Insert result or false.
    function xp.insert_new_xp(source, xp_id, xp_type)
        local identifier = core.get_player_id(source) or (source).license
        if not identifier then return false end

        local xp_static = UTILS.DATA.xp
        if not xp_static then return false end

        local xp_data = xp_static[xp_id]
        if not xp_data or xp_data.type ~= xp_type then return false end

        local required_xp = xp.calculate_required_xp(xp_data.level, xp_data.first_level_xp, xp_data.growth_factor)

        local query = "INSERT IGNORE INTO utils_xp (identifier, xp_id, type, category, level, xp, xp_required, growth_factor, max_level, decay_rate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        local result = MySQL.insert.await(query, {
            identifier,
            xp_id,
            xp_data.type,
            xp_data.category,
            xp_data.level,
            xp_data.xp,
            required_xp,
            xp_data.growth_factor,
            xp_data.max_level or nil,
            xp_data.decay_rate or nil
        })

        return result or false
    end

    --- Initializes XP data for a player.
    --- @param source number: The player source ID.
    --- @return table: XP data table.
    function xp.init_xp(source)
        local identifier = core.get_player_id(source) or graft.get_identifiers(source).license
        if not identifier then return {} end

        local query = "SELECT xp_id, type, category, level, xp, xp_required, growth_factor, max_level, decay_rate FROM utils_xp WHERE identifier = ?"
        local results = MySQL.query.await(query, { identifier })

        local xp_data = {}
        for _, row in ipairs(results or {}) do
            xp_data[row.type .. "_" .. row.xp_id] = {
                type = row.type,
                category = row.category,
                level = row.level,
                xp = row.xp,
                xp_required = row.xp_required,
                growth_factor = row.growth_factor,
                max_level = row.max_level,
                decay_rate = row.decay_rate
            }
        end

        player_xp[source] = xp_data
        return xp_data
    end

    --- Retrieves all XP data for a player.
    --- @param source number: The player source ID.
    --- @return table: All XP entries for the player.
    function xp.get_all_xp(source)
        if not player_xp[source] then return xp.init_xp(source) end
        return player_xp[source]
    end

    --- Retrieves a specific XP entry.
    --- @param source number: The player source ID.
    --- @param xp_type string: XP type.
    --- @param xp_id string: XP ID.
    --- @return table|nil: XP entry table.
    function xp.get_xp(source, xp_type, xp_id)
        local all_xp = xp.get_all(source)
        return all_xp[xp_type .. "_" .. xp_id]
    end

    --- Sets a specific XP value.
    --- @param source number: Player source ID.
    --- @param xp_type string: XP type.
    --- @param xp_id string: XP ID.
    --- @param amount number: XP amount to set.
    --- @return boolean
    function xp.set_xp(source, xp_type, xp_id, amount)
        local identifier = core.get_player_id(source) or graft.get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = xp.get(source, xp_type, xp_id)
        if not xp_entry then xp.insert_new_xp(source, xp_id, xp_type) xp_entry = xp.get(source, xp_type, xp_id) end

        xp_entry.xp = amount
        local query = "UPDATE utils_xp SET xp = ? WHERE identifier = ? AND xp_id = ? AND type = ?"
        MySQL.update.await(query, { amount, identifier, xp_id, xp_type })

        return true
    end

    --- Adds XP to a specific entry.
    --- @param source number: Player source ID.
    --- @param xp_type string: XP type.
    --- @param xp_id string: XP ID.
    --- @param amount number: XP amount to add.
    --- @return boolean
    function xp.add_xp(source, xp_type, xp_id, amount)
        local identifier = core.get_player_id(source) or graft.get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = xp.get(source, xp_type, xp_id)
        if not xp_entry then xp.insert_new_xp(source, xp_id, xp_type) xp_entry = xp.get(source, xp_type, xp_id) end

        local new_xp = xp_entry.xp + amount
        if xp_entry.max_level and new_xp > xp_entry.max_level then new_xp = xp_entry.max_level end

        while new_xp >= xp_entry.xp_required do
            xp_entry.level = xp_entry.level + 1
            new_xp = new_xp - xp_entry.xp_required
            xp_entry.xp_required = xp.calculate_required_xp(xp_entry.level, UTILS.DATA.xp[xp_id].first_level_xp, xp_entry.growth_factor)
        end

        xp_entry.xp = new_xp
        local query = "UPDATE utils_xp SET level = ?, xp = ?, xp_required = ? WHERE identifier = ? AND xp_id = ? AND type = ?"
        MySQL.update.await(query, { xp_entry.level, xp_entry.xp, xp_entry.xp_required, identifier, xp_id, xp_type })

        return true
    end

    --- Removes XP from a specific entry.
    --- @param source number: Player source ID.
    --- @param xp_type string: XP type.
    --- @param xp_id string: XP ID.
    --- @param amount number: XP amount to remove.
    --- @return boolean
    function xp.remove_xp(source, xp_type, xp_id, amount)
        local identifier = core.get_player_id(source) or graft.get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = xp.get(source, xp_type, xp_id)
        if not xp_entry then xp.insert_new_xp(source, xp_id, xp_type) xp_entry = xp.get(source, xp_type, xp_id) end

        local new_xp = xp_entry.xp - amount
        if new_xp < 0 then new_xp = 0 end

        while new_xp < 0 and xp_entry.level > 1 do
            xp_entry.level = xp_entry.level - 1
            xp_entry.xp_required = xp.calculate_required_xp(xp_entry.level, UTILS.DATA.xp[xp_id].first_level_xp, xp_entry.growth_factor)
            new_xp = xp_entry.xp_required + new_xp
        end

        xp_entry.xp = new_xp
        local query = "UPDATE utils_xp SET level = ?, xp = ?, xp_required = ? WHERE identifier = ? AND xp_id = ? AND type = ?"
        MySQL.update.await(query, { xp_entry.level, xp_entry.xp, xp_entry.xp_required, identifier, xp_id, xp_type })

        return true
    end

else

    local callbacks <const> = graft.get("lib.modules.callbacks")

    --- Gets all XP for the current player.
    --- @return table|nil: XP data if successful.
    function xp.get_all()
        callbacks.trigger("graft:sv:get_all_xp", nil, function(response)
            if response.success and response.xp then
                return response.xp
            end
        end)
    end

end

return xp

--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don’t be that guy...
]]

if graft.framework ~= "qb" then return end

local bridge = {}
local QBCore = exports["qb-core"]:GetCoreObject()
local tables <const> = graft.get("lib.modules.tables")

if graft.is_server then

    --- @section Players

    --- Retrieves all players
    --- @return players table
    function bridge.get_players()
        return QBCore.Functions.GetPlayers()
    end

    --- Retrieves player data from the server based on the framework.
    --- @param source number: Player source identifier.
    --- @return Player data object.
    function bridge.get_player(source)
        return QBCore.Functions.GetPlayer(source)
    end

    --- @section Database

    --- Prepares query parameters for database operations.
    --- @param source number: Player source identifier.
    --- @return Query part and parameters.
    function bridge.get_id_params(source)
        local player = bridge.get_player(source)
        return "citizenid = ?", { player.PlayerData.citizenid }
    end

    --- @section Identity

    --- Retrieves player character unique id.
    --- @param source number: Player source identifier.
    --- @return Players main identifier.
    function bridge.get_player_id(source)
        local player = bridge.get_player(source)
        return player and player.PlayerData.citizenid or false
    end

    --- Retrieves a players identity information.
    --- @param source number: Player source identifier.
    --- @return Table of players identity information.
    function bridge.get_identity(source)
        local player = bridge.get_player(source)
        if not player then return false end
        return {
            first_name = player.PlayerData.charinfo.firstname,
            last_name = player.PlayerData.charinfo.lastname,
            dob = player.PlayerData.charinfo.birthdate,
            sex = player.PlayerData.charinfo.gender,
            nationality = player.PlayerData.charinfo.nationality
        }
    end

    --- Retrieves a players identity information by their id (citizenid, unique_id+char_id, etc..)
    --- @param unique_id string: The id of the user to retrieve identity information for.
    --- @return Table of identity information.
    function bridge.get_identity_by_id(unique_id)
        for _, src in ipairs(bridge.get_players()) do
            if bridge.get_player_id(src) == unique_id then
                return bridge.get_identity(src)
            end
        end
        return nil
    end

    --- @section Inventory

    --- Gets a players inventory data
    --- @param source Player source identifier.
    --- @return The players inventory.
    function bridge.get_inventory(source)
        if GetResourceState("ox_inventory") == "started" then
            return exports.ox_inventory:GetInventory(source, false)
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            return inv and inv:get_items() or {}
        end

        local player = bridge.get_player(source)
        return player and player.PlayerData.inventory or {}
    end

    --- Retrieves an item from the players inventory.
    --- @param source number: Player source identifier.
    --- @param item_name string: Name of the item to retrieve.
    --- @return Item object if found, nil otherwise.
    function bridge.get_item(source, item_name)
        if GetResourceState("ox_inventory") == "started" then
            local items = exports.ox_inventory:Search(source, "items", item_name)
            return items and items[1]
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            return inv and inv:get_item(item_name) or nil
        end

        local player = bridge.get_player(source)
        return player and player.Functions.GetItemByName(item_name) or nil
    end

    --- Checks if a player has a specific item in their inventory.
    --- @param source number: Player source identifier.
    --- @param item_name string: Name of the item to check.
    --- @param item_amount number: (Optional) Amount of the item to check for.
    --- @return True if the player has the item (and amount), False otherwise.
    function bridge.has_item(source, item_name, item_amount)
        local amt = item_amount or 1

        if GetResourceState("ox_inventory") == "started" then
            local count = exports.ox_inventory:Search(source, "count", item_name)
            return count and count >= amt
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            return inv and inv:has_item(item_name, amt) == true
        end

        local player = bridge.get_player(source)
        if not player then return false end

        local item = player.Functions.GetItemByName(item_name)
        return item and item.amount >= amt
    end

    --- Adds an item to a players inventory.
    --- @param source number: Player source identifier.
    --- @param item_id string: The ID of the item to add.
    --- @param amount number: The amount of the item to add.
    --- @param data table|nil: Optional metadata for the item.
    function bridge.add_item(source, item_id, amount, data)
        if GetResourceState("ox_inventory") == "started" then
            return exports.ox_inventory:AddItem(source, item_id, amount, data)
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            return inv and inv:add_item(item_id, amount, data)
        end

        local player = bridge.get_player(source)
        if not player then return false end

        player.Functions.AddItem(item_id, amount, nil, data)
        TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item_id], "add", amount)
    end

    --- Removes an item from a players inventory.
    --- @param source number: Player source identifier.
    --- @param item_id string: The ID of the item to remove.
    --- @param amount number: The amount of the item to remove.
    function bridge.remove_item(source, item_id, amount)
        if GetResourceState("ox_inventory") == "started" then
            return exports.ox_inventory:RemoveItem(source, item_id, amount)
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            return inv and inv:remove_item(item_id, amount)
        end

        local player = bridge.get_player(source)
        if not player then return false end

        player.Functions.RemoveItem(item_id, amount)
        TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item_id], "remove", amount)
    end

    --- Updates the item data for a player.
    --- @param source number: The players source identifier.
    --- @param item_id string: The ID of the item to update.
    --- @param updates table: Table containing updates like ammo count, attachments etc.
    function bridge.update_item_data(source, item_id, updates)
        if GetResourceState("ox_inventory") == "started" then
            local items = exports.ox_inventory:Search(source, 1, item_id)
            for _, v in pairs(items) do
                for k, val in pairs(updates) do
                    v.metadata[k] = val
                end
                exports.ox_inventory:SetMetadata(source, v.slot, v.metadata)
                break
            end
            return
        end

        if GetResourceState("list_inventory") == "started" then
            local inv = exports.list_inventory:get_player(source)
            if not inv then return end

            for slot, item in pairs(inv:get_items()) do
                if item.id == item_id then
                    return inv:update_item_data(slot, updates)
                end
            end
            return
        end

        for k, val in pairs(updates) do
            exports["qb-inventory"]:SetItemData(source, item_id, k, val)
        end
    end

    --- @section Balances

    --- Retrieves the balances of a player.
    --- @param source number: Player source identifier.
    --- @return A table of balances by type.
    function bridge.get_balances(source)
        local player = bridge.get_player(source)
        return player and player.PlayerData.money or {}
    end

    --- Retrieves a specific balance of a player by type.
    --- @param source number: Player source identifier.
    --- @param balance_type string: The type of balance to retrieve.
    --- @return The balance amount for the specified type.
    function bridge.get_balance_by_type(source, balance_type)
        local balances = bridge.get_balances(source)
        return balances and balances[balance_type] or 0
    end

    --- Adds money to a players balance.
    --- @param source number: Player source identifier.
    --- @param balance_type string: The type of balance to adjust.
    --- @param amount number: The amount to add.
    function bridge.add_balance(source, balance_type, amount)
        local player = bridge.get_player(source)
        if player then player.Functions.AddMoney(balance_type, amount) end
    end

    --- Removes money from a players balance.
    --- @param source number: Player source identifier.
    --- @param balance_type string: The type of balance to adjust.
    --- @param amount number: The amount to remove.
    function bridge.remove_balance(source, balance_type, amount)
        local player = bridge.get_player(source)
        if player then player.Functions.RemoveMoney(balance_type, amount) end
    end

    --- @section Jobs

    --- Retrieves the job(s) of a player by their source identifier.
    --- @param source number: The players source identifier.
    --- @return A table containing the players jobs and their on-duty status.
    function bridge.get_player_jobs(source)
        local player = bridge.get_player(source)
        return player and player.PlayerData.job or {}
    end

    --- Checks if a player has one of the specified jobs and optionally checks their on-duty status.
    --- @param source number: The players source identifier.
    --- @param job_names table: An array of job names to check against the players jobs.
    --- @param check_on_duty boolean: Optional boolean to also check if the player is on-duty for the job.
    --- @return Boolean indicating if the player has any of the specified jobs and meets the on-duty condition.
    function bridge.player_has_job(source, job_names, check_on_duty)
        local job = bridge.get_player_jobs(source)
        local match = tables.table_contains(job_names, job.name)
        return match and (not check_on_duty or job.onduty)
    end

    --- Retrieves a players job grade for a specified job.
    --- @param source number: The players source identifier.
    --- @param job_id string: The job ID to retrieve the grade for.
    --- @return The grade of the player for the specified job, or nil if not found.
    function bridge.get_player_job_grade(source, job_id)
        local job = bridge.get_player_jobs(source)
        return (job and job.name == job_id) and job.grade.level or nil
    end

    --- Counts players with a specific job and optionally filters by on-duty status.
    --- @param job_names table: Table of job names to check against the players jobs.
    --- @param check_on_duty boolean: Optional boolean to also check if the player is on-duty for the job.
    --- @return Two numbers: total players with the job, and total players with the job who are on-duty.
    function bridge.count_players_by_job(job_names, check_on_duty)
        local with_job, on_duty = 0, 0
        for _, src in ipairs(bridge.get_players()) do
            if bridge.player_has_job(src, job_names, false) then
                with_job += 1
                if bridge.player_has_job(src, job_names, true) then
                    on_duty += 1
                end
            end
        end
        return with_job, on_duty
    end

    --- Returns a players job name.
    --- @param source number: The players source identifier.
    function bridge.get_player_job_name(source)
        local job = bridge.get_player_jobs(source)
        return job and job.name or nil
    end

    --- @section Statuses

    --- Modifies a players server-side statuses.
    --- @param source The players source identifier.
    --- @param statuses The statuses to modify.
    function bridge.adjust_statuses(source, statuses)
        local player = bridge.get_player(source)
        if not player then return false end

        local meta = player.PlayerData.metadata
        for key, mod in pairs(statuses) do
            local status_key = (key == "armor" and "armour") or key
            local add = (mod.add and mod.add.min and mod.add.max) and math.random(mod.add.min, mod.add.max) or 0
            local sub = (mod.remove and mod.remove.min and mod.remove.max) and math.random(mod.remove.min, mod.remove.max) or 0
            local change = add - sub
            local current = meta[status_key] or 0
            local new = math.min(100, math.max(0, current + change))

            if status_key == "stress" then
                if change > 0 then
                    TriggerEvent("hud:server:GainStress", change, source)
                else
                    TriggerEvent("hud:server:RelieveStress", -change, source)
                end
            elseif status_key == "hunger" or status_key == "thirst" then
                TriggerClientEvent("hud:client:UpdateNeeds", source, meta.hunger, meta.thirst)
            end

            player.Functions.SetMetaData(status_key, new)
        end
    end

    --- @section Usable Items

    --- Register an item as usable for different frameworks.
    --- @param item string: The item identifier.
    --- @param cb function: The callback function to execute when the item is used.
    function bridge.register_item(item, cb)
        if not item then return false end
        QBCore.Functions.CreateUseableItem(item, function(src) cb(src) end)
    end

else

    --- @section Player Data

    --- Retrieves a players client-side data based on the active framework.
    --- @return table: The requested player data.
    function bridge.get_data()
        return QBCore.Functions.GetPlayerData()
    end

    --- Retrieves a players identity information.
    --- @return table: The players identity information (first name, last name, date of birth, sex, nationality).
    function bridge.get_identity()
        local player = bridge.get_data()
        return {
            first_name = player.charinfo.firstname,
            last_name = player.charinfo.lastname,
            dob = player.charinfo.birthdate,
            sex = player.charinfo.gender,
            nationality = player.charinfo.nationality
        }
    end

    --- Retrieves player unique id.
    --- @return Players main identifier.
    function bridge.get_player_id()
        local player = bridge.get_data()
        return player.citizenid
    end

end

return bridge
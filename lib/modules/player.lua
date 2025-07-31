--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

--- @module player
--- Handles a selection of custom functions for players.
--- Most useful is probably the `play_animation()` function, allows for anims with prop support.

local requests <const> = graft.get("lib.modules.requests")
local debugging <const> = graft.get("lib.modules.debugging")

--- @module Player

local player = {}

--- Gets a player"s cardinal direction based on their current heading.
--- @param player number: The player ped use "PlayerPedId()" on client and "GetPlayerPed(source)" on server.
--- @return string: The cardinal direction the player is facing.
function player.get_cardinal_direction(player_ped)
    if not player_ped then return false end
    
    local heading = GetEntityHeading(player_ped)
    if not heading then return false end

    local directions = { "N", "NE", "E", "SE", "S", "SW", "W", "NW" }
    local index = math.floor(((heading + 22.5) % 360) / 45) + 1

    return directions[index]
end

--- Calculates the distance between a player and an entity.
--- @param player any: The player identifier "GetPlayerPed(source)" on server, "PlayerPedId()"  on client.
--- @param entity number: The target entity or net id on server.
--- @return number: The distance between the player and the entity.
function player.get_distance_to_entity(player_ped, entity)
    local player_coords = GetEntityCoords(player_ped)
    local entity_coords = GetEntityCoords(entity)
    return #(player_coords - entity_coords)
end

if not graft.is_server then

    --- Retrieves the street name and area where a player is currently located.
    --- @param player_ped number: The player entity.
    --- @return string: The street and area name the player is on.
    function player.get_street_name(player_ped)
        local player_coords = GetEntityCoords(player_ped)
        local street_hash, _ = GetStreetNameAtCoord(player_coords.x, player_coords.y, player_coords.z)
        local street_name = GetStreetNameFromHashKey(street_hash)
        local area_name = GetLabelText(GetNameOfZone(player_coords.x, player_coords.y, player_coords.z))

        return table.concat({ street_name, area_name }, street_name and area_name and ", " or ""):match("%S") or "Unknown"
    end

    --- Retrieves the name of the region a player is currently in.
    --- @param player number: The player entity.
    --- @return string: The region name the player is in.
    function player.get_region(player_ped)
        local player_coords = GetEntityCoords(player_ped)
        return GetNameOfZone(player_coords.x, player_coords.y, player_coords.z)
    end

    --- Retrieves detailed information about a player.
    --- @param player number: The player entity.
    --- @return table: A table containing detailed information about the player.
    function player.get_player_details(player_ped)
        local data = {}

        data.server_id = GetPlayerServerId(player_ped)
        data.name = GetPlayerName(player_ped)
        data.max_stamina = GetPlayerMaxStamina(player_ped)
        data.stamina = GetPlayerStamina(player_ped)
        data.health = GetEntityHealth(player_ped)
        data.armor = GetPedArmour(player_ped)
        data.melee_damage_modifier = GetPlayerMeleeWeaponDamageModifier(player_ped)
        data.melee_defense_modifier = GetPlayerMeleeWeaponDefenseModifier(player_ped)
        data.vehicle_damage_modifier = GetPlayerVehicleDamageModifier(player_ped)
        data.vehicle_defense_modifier = GetPlayerVehicleDefenseModifier(player_ped)
        data.weapon_damage_modifier = GetPlayerWeaponDamageModifier(player_ped)
        data.weapon_defense_modifier = GetPlayerWeaponDefenseModifier(player_ped)
        local player_coords = GetEntityCoords(player_ped)
        data.coords = vector4(player_coords.x, player_coords.y, player_coords.z, GetEntityHeading(player_ped))
        data.model_hash = GetEntityModel(player_ped)

        return data
    end

    --- Retrieves the entity a player is targeting.
    --- @param player number: The player entity.
    --- @return number: The entity that the player is targeting.
    function player.get_target_entity(player_ped)
        local entity = 0

        if IsPlayerFreeAiming(player_ped) then
            local success, target = GetEntityPlayerIsFreeAimingAt(player_ped)
            if success then
                entity = target
            end
        end

        return entity
    end

    --- Runs animation on the player with params.
    --- @param player_ped number: The player entity.
    --- @param options table: Table of options to run when playing.
    --- @param callback function: Callback function to run when animation has finished.
    function player.play_animation(player_ped, options, callback)
        if not player_ped then debugging.log("error", "player_ped ped is missing") return end
        if not options or not options.dict or not options.anim then debugging.log("error", "Options or animation dictionary/animation name is missing") return end
        requests.anim(options.dict)
        if options.freeze then FreezeEntityPosition(player_ped, true) end
        local duration = options.duration or 2000
        local props = {}
        if options.props then
            for _, prop in ipairs(options.props) do
                requests.model(prop.model)
                local prop_entity = CreateObject(GetHashKey(prop.model), GetEntityCoords(player_ped), true, true, true)
                AttachEntityToEntity(prop_entity, player_ped, GetPedBoneIndex(player_ped, prop.bone), prop.coords.x or 0.0, prop.coords.y or 0.0, prop.coords.z or 0.0, prop.rotation.x or 0.0, prop.rotation.y or 0.0, prop.rotation.z or 0.0, true, prop.use_soft or false, prop.collision or false, prop.is_ped or true, prop.rot_order or 1, prop.sync_rot or true)
                table.insert(props, prop_entity)
            end
        end
        if options.continuous then
            TaskPlayAnim(player_ped, options.dict, options.anim, options.blend_in or 8.0, options.blend_out or -8.0, -1, options.flags or 49, options.playback or 0, options.lock_x or 0, options.lock_y or 0, options.lock_z or 0)
        else
            TaskPlayAnim(player_ped, options.dict, options.anim, options.blend_in or 8.0, options.blend_out or -8.0, duration, options.flags or 49, options.playback or 0, options.lock_x or 0, options.lock_y or 0, options.lock_z or 0)
            Wait(duration)
            ClearPedTasks(player_ped)
            if options.freeze then FreezeEntityPosition(player_ped, false) end
            for _, prop_entity in ipairs(props) do DeleteObject(prop_entity) end
            if callback then callback() end
        end
    end


end

return player

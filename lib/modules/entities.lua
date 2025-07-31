--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module entities
--- Handles entity based functions such as getting nearby entities or objects and more.

local entities = {}

if not graft.is_server then

    --- @section API Functions

    --- Find nearby entities.
    --- @param pool string: The type of entity pool to search in (e.g., "CObject", "CPed", "CVehicle").
    --- @param coords vector3: The reference coordinates to search from (e.g., player or vehicle position).
    --- @param max_distance number: The maximum distance within which to search for entities.
    --- @param filter function: (Optional) A function to apply additional filtering logic. Should return `true` to include the entity.
    --- @return table: A table containing a list of entities and their coordinates.
    function entities.get_nearby_entities(pool, coords, max_distance, filter)
        local entities = GetGamePool(pool)
        local nearby = {}
        local count = 0
        max_distance = max_distance or 2.0

        for i = 1, #entities do
            local entity = entities[i]
            local entity_coords = GetEntityCoords(entity)
            local distance = #(coords - entity_coords)
            if distance < max_distance and (not filter or filter(entity)) then
                count = count + 1
                nearby[count] = { entity = entity, coords = entity_coords }
            end
        end

        return nearby
    end

    --- Retrieves the closest entity of a given type.
    --- @param pool string: The type of entity pool to search in (e.g., "CPed", "CVehicle").
    --- @param coords vector3: The reference coordinates to search from.
    --- @param max_distance number: The maximum distance to consider.
    --- @param filter function|nil: Optional filter function to validate entities.
    --- @return number|nil, vector3|nil: Closest entity and its coords (or nil if none).
    function entities.get_closest_entity(pool, coords, max_distance, filter)
        local nearby = entities.get_nearby_entities(pool, coords, max_distance, filter)
        local closest_entity, closest_coords, closest_dist = nil, nil, max_distance or 2.0

        for _, entry in ipairs(nearby) do
            local dist = #(coords - entry.coords)
            if dist < closest_dist then
                closest_entity = entry.entity
                closest_coords = entry.coords
                closest_dist = dist
            end
        end

        return closest_entity, closest_coords
    end

    --- Retrieves nearby objects.
    --- @param coords vector3: Reference position, usually from a player or vehicle.
    --- @param max_distance number: Maximum distance to check.
    --- @return table: List of nearby object entities and their positions.
    function entities.get_nearby_objects(coords, max_distance)
        return entities.get_nearby_entities("CObject", coords, max_distance)
    end

    --- Retrieves nearby peds, excluding players.
    --- @param coords vector3: Reference position, usually from a player or vehicle.
    --- @param max_distance number: Maximum distance to check.
    --- @return table: List of nearby ped entities and their positions.
    function entities.get_nearby_peds(coords, max_distance)
        return entities.get_nearby_entities("CPed", coords, max_distance, function(ped)
            return not IsPedAPlayer(ped)
        end)
    end

    --- Retrieves nearby players.
    --- @param coords vector3: Reference position, usually from a player or vehicle.
    --- @param max_distance number: Maximum distance to check.
    --- @param include_player boolean: Whether to include the local player.
    --- @return table: List of nearby player peds and their positions.
    function entities.get_nearby_players(coords, max_distance, include_player)
        local player_id = PlayerId()
        return entities.get_nearby_entities("CPed", coords, max_distance, function(ped)
            local ped_player_id = NetworkGetEntityOwner(ped)
            return include_player or ped_player_id ~= player_id
        end)
    end

    --- Retrieves nearby vehicles.
    --- @param coords vector3: Reference position, usually from a player or vehicle.
    --- @param max_distance number: Maximum distance to check.
    --- @param include_player_vehicle boolean: Whether to include the vehicle the player is in.
    --- @return table: List of nearby vehicle entities and their positions.
    function entities.get_nearby_vehicles(coords, max_distance, include_player_vehicle)
        local player_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        return entities.get_nearby_entities("CVehicle", coords, max_distance, function(vehicle)
            return include_player_vehicle or vehicle ~= player_vehicle
        end)
    end

    --- Retrieves the closest object.
    --- @param coords vector3: Reference position to search from.
    --- @param max_distance number: Maximum distance to search.
    --- @return number, vector3: Object entity and its coordinates.
    function entities.get_closest_object(coords, max_distance)
        return entities.get_closest_entity("CObject", coords, max_distance)
    end

    --- Retrieves the closest ped.
    --- @param coords vector3: Reference position to search from.
    --- @param max_distance number: Maximum distance to search.
    --- @return number, vector3: Ped entity and its coordinates.
    function entities.get_closest_ped(coords, max_distance)
        return entities.get_closest_entity("CPed", coords, max_distance, function(ped)
            return not IsPedAPlayer(ped)
        end)
    end

    --- Retrieves the closest player.
    --- @param coords vector3: Reference position to search from.
    --- @param max_distance number: Maximum distance to search.
    --- @param include_player boolean: Whether to include the local player.
    --- @return number, vector3: Player ped and its coordinates.
    function entities.get_closest_player(coords, max_distance, include_player)
        return entities.get_closest_entity("CPed", coords, max_distance, function(ped)
            local ped_player_id = NetworkGetEntityOwner(ped)
            return include_player or ped_player_id ~= PlayerId()
        end)
    end

    --- Retrieves the closest vehicle.
    --- @param coords vector3: Reference position to search from.
    --- @param max_distance number: Maximum distance to search.
    --- @param include_player_vehicle boolean: Whether to include the players current vehicle.
    --- @return number, vector3: Vehicle entity and its coordinates.
    function entities.get_closest_vehicle(coords, max_distance, include_player_vehicle)
        return entities.get_closest_entity("CVehicle", coords, max_distance, function(vehicle)
            return include_player_vehicle or vehicle ~= GetVehiclePedIsIn(PlayerPedId(), false)
        end)
    end

    --- Get entities in front of the player.
    --- @param fov number: Field of view in degrees.
    --- @param distance number: Distance to project forward.
    --- @return number|nil: The entity hit, or nil if none.
    function entities.get_entities_in_front_of_player(fov, distance)
        local player = PlayerPedId()
        local player_coords = GetEntityCoords(player)
        local forward_vector = GetEntityForwardVector(player)
        local end_coords = vector3(player_coords.x + forward_vector.x * distance, player_coords.y + forward_vector.y * distance, player_coords.z + forward_vector.z * distance)
        local hit, _, _, _, entity = StartShapeTestRay( player_coords.x, player_coords.y, player_coords.z, end_coords.x, end_coords.y, end_coords.z, -1, player, 0)
        return hit and GetEntityType(entity) ~= 0 and entity or nil
    end

    --- Get the target ped or nearest ped.
    --- @param player_ped number: Ped of the local player.
    --- @param fov number: Field of view in degrees.
    --- @param distance number: Maximum distance to check.
    --- @return number, vector3: Ped entity and coordinates.
    function entities.get_target_ped(player_ped, fov, distance)
        local entity = entities.get_entities_in_front_of_player(fov, distance)
        if entity and IsEntityAPed(entity) and not IsPedAPlayer(entity) then
            return entity, GetEntityCoords(entity)
        end
        return entities.get_closest_ped(GetEntityCoords(player_ped), distance)
    end

end

return entities

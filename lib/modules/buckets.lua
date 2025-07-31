--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

--- @module buckets
--- Routing bucket definitions and utility access functions.
--- Honestly? Mostly pointless but I have a personal use case for these.

local buckets = {}

if graft.is_server then

    --- Full bucket definition list.
    local bucket_list = {
        main = {
            label = "Main World", -- label for display
            bucket = 0, -- default bucket
            mode = "strict", -- https://docs.fivem.net/natives/?_0xA0F2201F
            population_enabled = false, -- https://docs.fivem.net/natives/?_0xCE51AC2C
            player_cap = false, -- false | number: for setting player limits.
            staff_only = false, -- e.g. { "admin", "mod" }
            vip_only = false, -- e.g. 2 = VIP level 2 required
            spawn = vector4(-268.47, -956.98, 31.22, 208.54),
            respawn = vector4(341.28, -1396.83, 32.51, 48.78)
        }
    }

    --- Returns the full bucket config for a given ID.
    --- @param id string: The bucket ID.
    --- @return table|nil: The bucket config if found.
    function buckets.get_bucket(id)
        return buckets.bucket_list[id]
    end

    --- Returns the bucket config matching a label.
    --- @param label string: The label to search.
    --- @return table|nil: The matching config if found.
    function buckets.get_bucket_by_label(label)
        for _, bucket in pairs(buckets.bucket_list) do
            if bucket.label:lower() == label:lower() then return bucket end
        end
    end

    --- Returns the spawn point for a bucket.
    --- @param id string: The bucket ID.
    --- @return vector4|nil: The spawn point or nil.
    function buckets.get_bucket_spawn(id)
        return buckets.bucket_list[id] and buckets.bucket_list[id].spawn or nil
    end

    --- Returns the respawn point for a bucket.
    --- @param id string: The bucket ID.
    --- @return vector4|nil: The respawn point or nil.
    function buckets.get_bucket_respawn(id)
        return buckets.bucket_list[id] and buckets.bucket_list[id].respawn or nil
    end

    --- Checks if a bucket is staff-only for a given role.
    --- @param id string: The bucket ID.
    --- @param role string: The role to check.
    --- @return boolean: True if restricted.
    function buckets.is_bucket_staff_only(id, role)
        local data = buckets.bucket_list[id]
        if not data or not data.staff_only then return false end
        for _, allowed in ipairs(data.staff_only) do
            if allowed == role then return false end
        end
        return true
    end

    --- Checks if a bucket is VIP-only for a given VIP level.
    --- @param id string: The bucket ID.
    --- @param vip_level number: The players VIP level.
    --- @return boolean: True if restricted.
    function buckets.is_bucket_vip_only(id, vip_level)
        local data = buckets.bucket_list[id]
        return data and data.vip_only and (vip_level or 0) < data.vip_only
    end

    --- Applies routing settings to all configured buckets.
    --- @return void
    function buckets.apply_bucket_settings()
        for _, data in pairs(buckets.bucket_list) do
            SetRoutingBucketPopulationEnabled(data.bucket, data.population_enabled)
            SetRoutingBucketEntityLockdownMode(data.bucket, data.mode)
        end
    end

end

return buckets

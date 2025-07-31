--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don"t be that guy...
]]

if graft.framework ~= "standalone" then return end

local bridge = {}

if graft.is_server then

    -- Players
    function bridge.get_players()
        print("[graft:standalone] get_players")
        return {}
    end

    function bridge.get_player()
        print("[graft:standalone] get_player")
        return false
    end

    -- Database
    function bridge.get_id_params()
        print("[graft:standalone] get_id_params")
        return "1=1", {}
    end

    -- Identity
    function bridge.get_identity()
        print("[graft:standalone] get_identity")
        return nil
    end

    -- Inventory
    function bridge.get_inventory()
        print("[graft:standalone] get_inventory")
        return {}
    end

    function bridge.get_item()
        print("[graft:standalone] get_item")
        return nil
    end

    function bridge.has_item()
        print("[graft:standalone] has_item")
        return false
    end

    function bridge.add_item()
        print("[graft:standalone] add_item")
        return false
    end

    function bridge.remove_item()
        print("[graft:standalone] remove_item")
        return false
    end

    function bridge.update_item_data()
        print("[graft:standalone] update_item_data")
        return false
    end

    -- Balances
    function bridge.get_balances()
        print("[graft:standalone] get_balances")
        return {}
    end

    function bridge.get_balance_by_type()
        print("[graft:standalone] get_balance_by_type")
        return 0
    end

    function bridge.add_balance()
        print("[graft:standalone] add_balance")
        return false
    end

    function bridge.remove_balance()
        print("[graft:standalone] remove_balance")
        return false
    end

    -- Jobs
    function bridge.get_player_jobs()
        print("[graft:standalone] get_player_jobs")
        return {}
    end

    function bridge.player_has_job()
        print("[graft:standalone] player_has_job")
        return false
    end

    function bridge.get_player_job_grade()
        print("[graft:standalone] get_player_job_grade")
        return nil
    end

    function bridge.count_players_by_job()
        print("[graft:standalone] count_players_by_job")
        return 0, 0
    end

    function bridge.get_player_job_name()
        print("[graft:standalone] get_player_job_name")
        return nil
    end

    -- Statuses
    function bridge.adjust_statuses()
        print("[graft:standalone] adjust_statuses")
        return false
    end

    -- Usable Items
    function bridge.register_item()
        print("[graft:standalone] register_item")
        return false
    end

else

    -- Client-side
    function bridge.get_data()
        print("[graft:standalone] get_data")
        return {}
    end

    function bridge.get_identity()
        print("[graft:standalone] get_identity")
        return nil
    end

    function bridge.get_player_id()
        print("[graft:standalone] get_player_id")
        return nil
    end

end

return bridge

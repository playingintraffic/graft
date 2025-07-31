--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module items
--- Standalone item registration.
--- Useful for framework / cores that do not have one natively.
--- Framework bridge functions cover core functionality for those that do.

local items = {}

if graft.is_server then 

    graft.usable_items = graft.usable_items or {}

    --- @section Local functions

    --- Function to register an item as usable.
    --- @param item_id The identifier of the item.
    --- @param use_function The function to be executed when the item is used.
    function items.register_item(item_id, use_function)
        graft.usable_items[item_id] = use_function
    end

    --- Function to use a registered item
    --- @param item_id The identifier of the item.
    function items.use_item(source, item_id)
        if graft.usable_items[item_id] then
            graft.usable_items[item_id](source, item_id)
        else
            print("Item with ID " .. item_id .. " is not registered as usable.")
        end
    end

end

return items
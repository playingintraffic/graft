--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module commands
--- Permissioned command registration and chat suggestion support.
--- Relies on the included `utils_users` table. 
--- You can change users permission ranks in database. 

local commands = {}

--- @section Import Modules

local debugging <const> = graft.get("lib.modules.debugging")

--- @section Tables

local chat_suggestions = {}

if graft.is_server then

    --- @section Internal Functions

    --- Checks if a user has the required permission rank.
    --- @param source number: The source ID of the player.
    --- @param required_rank string|table|nil: The required rank or ranks.
    --- @return boolean: True if the user has the required permission.
    local function has_permission(source, required_rank)
        if not required_rank then return true end

        local user = get_user(source)
        if not user then debugging.log("error", "user not found when using command") return false end

        local user_rank = user.rank
        local ranks = type(required_rank) == "table" and required_rank or { required_rank }

        for _, rank in ipairs(ranks) do
            if rank == user_rank or rank == "all" then return true end
        end

        return false
    end

    --- Registers chat suggestions.
    --- @param command string: The command name.
    --- @param help string: Description for help.
    --- @param params table: Optional parameter definitions.
    local function register_chat_suggestion(command, help, params)
        chat_suggestions[#chat_suggestions + 1] = { command = command, help = help, params = params }
    end

    --- @section API Functions

    --- Registers a command with permission and optional autocomplete.
    --- @param command string: Command name.
    --- @param required_rank string|table|nil: Allowed rank(s) or nil for open command.
    --- @param help string: Help description.
    --- @param params table: Chat suggestion param table.
    --- @param handler function: Command handler function.
    function commands.register_command(command, required_rank, help, params, handler)
        if help and params then register_chat_suggestion(command, help, params) end

        RegisterCommand(command, function(source, args, raw)
            if has_permission(source, required_rank) then
                handler(source, args, raw)
            else
                TriggerClientEvent("chat:addMessage", source, {
                    args = { "^1SYSTEM", "You do not have permission to execute this command." }
                })
            end
        end, false)
    end

else

    --- Requests server to resend chat suggestions.
    function commands.get_command_suggestions()
        TriggerServerEvent("graft:sv:request_chat_suggestions")
    end

end

return commands
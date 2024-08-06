vim.g.jira_url = "https://vailsys.atlassian.net/browse/"

local function open_jira_ticket()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD")
    local branch_name = handle:read("*a")
    handle:close()

    local ticket_id = string.match(branch_name, "/(%w+-%d+)%s*$")

    if ticket_id then
        local url = vim.g.jira_url .. ticket_id

        local command
        if vim.fn.has("mac") == 1 then
            command = "open "
        elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
            command = "start "
        else
            command = "xdg-open "
        end
        os.execute(command .. '"' .. url .. '"')
    else
        print("Ticket ID not found in the branch name")
    end
end

vim.api.nvim_create_user_command('OpenJiraTicket', open_jira_ticket, {})
vim.api.nvim_set_keymap('n', '<leader>jo', '<cmd>OpenJiraTicket<CR>', { noremap = true, silent = true })

return {}

-- Gives you the ability to run git commands from within vim
return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb",
        "shumphrey/fugitive-gitlab.vim",
    },
    config = function()
        vim.g.fugitive_gitlab_domains = {
            ["gitlab.vailsys.com"] = "gitlab.vailsys.com",
        }
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gb", ":GBrowse<CR>");

        local function last_commit_on_line()
            local line_number = vim.fn.line('.')
            local file_path = vim.fn.expand('%')
            local handle = io.popen('git blame -L ' ..
            line_number .. ',' .. line_number .. ' ' .. file_path .. ' | awk \'{print $1}\'')
            local commit_hash = handle:read("*a")
            handle:close()
            commit_hash = vim.fn.trim(commit_hash)
            vim.cmd('GBrowse ' .. commit_hash)
        end

        vim.keymap.set("n", "<leader>gl", last_commit_on_line, { desc = "Go to last commit on line" })

        local function open_merge_request()
            local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
            local repo = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
            repo = repo:gsub("git@%w+%.%w+:", ""):gsub("https?://%w+%.%w+/", ""):gsub("%.git$", "")
            local domain = vim.g.fugitive_gitlab_domains["gitlab.vailsys.com"]
            local encoded_branch = vim.fn.system("echo " .. branch .. " | jq -sRr @uri"):gsub("\n", ""):gsub("%%0A", "")
            local url = repo .. "/-/merge_requests?scope=all&state=opened&source_branch=" .. encoded_branch
            vim.fn.system({ "open", url })
        end
        vim.keymap.set("n", "<leader>gm", open_merge_request, { desc = "Open Merge Request" })

        local kevin_fugitive = vim.api.nvim_create_augroup("kevin_fugitive", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = kevin_fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end
                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ 'pull', '--rebase' })
                end, opts)
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}

-- quick search between files and text
local function find_git_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    if current_file == '' then
        current_dir = cwd
    else
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end
    local git_root = vim.fn.systemlist('git -C ' ..
        vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
    end
    return git_root
end


local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require('telescope.builtin').live_grep {
            search_dirs = { git_root },
        }
    end
end

local function telescope_current_buffer_fuzzy_find()
    require('telescope.builtin').current_buffer_fuzzy_find({
        prompt_title = '< Search in Current Buffer >',
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                mirror = true,
                width = 0.8,
                height = 0.4,
            }
        }
    })
end

local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        },
        "folke/trouble.nvim",
    },
    config = function()
        local open_with_trouble = require("trouble.sources.telescope").open

        require('telescope').setup({
            defaults = {
                layout_strategy = 'bottom_pane', -- using horizontal layout
                layout_config = {
                    horizontal = {
                        mirror = true,          -- this will place the prompt at the bottom
                        preview_width = 0.6,    -- adjust preview width as necessary
                    },
                    width = 0.8,                -- width of Telescope window (80% of the available screen)
                    height = 0.7,               -- height of Telescope window (40% of the available screen)
                    prompt_position = "bottom", -- position the prompt at the bottom of the Telescope window
                },
                mappings = {
                    i = {
                        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                        ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                        ["<M-t>"] = open_with_trouble,
                    },
                    n = { ["<M-t>"] = open_with_trouble },
                },
                file_ignore_patterns = {},
                find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
                -- other default configurations can be added here
            }
        })
        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
        vim.keymap.set('n', '<leader>so', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
        -- vim.keymap.set('n', '<leader>bo', ':Telescope buffers<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>sb', telescope_current_buffer_fuzzy_find, { desc = '[S]earch in Current [B]uffer' })
        -- vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
        -- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>ps', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
    end
}

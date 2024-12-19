-- quick search between files and text

local function telescope_current_directory_file_search()
    require('telescope.builtin').find_files({ find_command = { 'rg', '--ignore', '--hidden', '--files' } })
end

local function telescope_current_buffer_fuzzy_find()
    require('telescope.builtin').current_buffer_fuzzy_find({ prompt_title = '< Search in Current Buffer >' })
end

local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
end

local function telescope_live_grep_all()
    require('telescope.builtin').live_grep({
        prompt_title = '< Live Grep in All Folders >',
        additional_args = function() return { "--hidden" } end -- Include hidden files
    })
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        },
        "folke/trouble.nvim",
    },
    config = function()
        local builtin = require('telescope.builtin')

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                        ["<C-j>"] = require('telescope.actions').cycle_history_next,
                        ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                        ["<C-k>"] = require('telescope.actions').cycle_history_prev,
                    },
                },
                file_ignore_patterns = {},
                prompt_prefix = '🔍'
            }
        })

        vim.keymap.set('n', '<leader>o', builtin.buffers, { desc = '[O]pen Buffers' })
        vim.keymap.set('n', '<leader>so', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
        vim.keymap.set('n', '<leader>sb', telescope_current_buffer_fuzzy_find, { desc = '[S]earch in Current [B]uffer' })
        vim.keymap.set('n', '<leader>pf', telescope_current_directory_file_search, { desc = '[P]roject Files' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>sg', telescope_live_grep_all, { desc = '[S]earch by [G]rep in All Folders' })

        -- buffers
        vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = '[B]uffers' })
        vim.keymap.set('n', '<leader>hh', builtin.buffers, { desc = '[B]uffers' })
        vim.keymap.set('n', '<leader>kj', builtin.buffers, { desc = '[B]uffers' })
    end
}

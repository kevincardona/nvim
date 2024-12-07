return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('bufferline').setup {
            options = {
                numbers = "none",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                indicator = {
                    icon = '▎',
                    style = 'icon',
                },
                max_name_length = 24,
            }
        }

        -- Key mappings for buffer navigation
        vim.keymap.set('n', '<leader>k', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>j', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { noremap = true, silent = true })
    end
}

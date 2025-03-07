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
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center"
                    }
                },
                max_name_length = 24,
            }
        }

        -- Key mappings for buffer navigation
        vim.keymap.set('n', '<leader>k', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>j', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>b$', ':BufferLineCloseRight<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>b0', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bh', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bl', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
        -- toggle buffer by number
        vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
    end
}

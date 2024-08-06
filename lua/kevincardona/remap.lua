local opts = { noremap = true, silent = true }
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Disable Ctrl + U in insert mode
vim.api.nvim_set_keymap('i', '<C-u>', '<NOP>', { noremap = true, silent = true })

-- project navigation
vim.keymap.set('n', '<leader>e', ":NvimTreeFindFileToggle!<CR>", { noremap = true, silent = true })

-- git
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lc', ':LazyGitFilterCurrentFile<CR>', { noremap = true, silent = true })

-- copy the absolute path of the current file to the clipboard and show a message
vim.keymap.set('n', '<leader>fa', ':let @+=expand("%:p")<CR>:echo "Copied absolute path: " . expand("%:p")<CR>',
    { noremap = true, silent = false })

-- copy the relative path of the current file to the clipboard and show a message
vim.keymap.set('n', '<leader>fr', ':let @+=expand("%")<CR>:echo "Copied relative path: " . expand("%")<CR>',
    { noremap = true, silent = false })

-- window resize
vim.api.nvim_set_keymap('n', '<leader><Up>', ':resize +10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Down>', ':resize -10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Left>', ':vertical resize +20<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Right>', ':vertical resize -20<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

-- Remap [[ and ]] to move to the previous and next paragraph
vim.api.nvim_set_keymap('n', '[[', '', { noremap = true })
vim.api.nvim_set_keymap('n', ']]', '', { noremap = true })
vim.api.nvim_set_keymap('n', '[[', '{', { noremap = true })
vim.api.nvim_set_keymap('n', ']]', '}', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- autocomplete
vim.keymap.set('n', '<leader>ac', ':Copilot panel<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>af', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- prevent yank on delete
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'X', '"_X', { noremap = true })

-- prevent yank on change, delete, and x
local ci_commands = { 'ci"', "ci'", "ci(", "ci)", "ciw", "cw", "cil", "ci[", "ci]", "ci{", "ci}", "ci`", "di'", 'di"',
    "di(", "di)", "di[",
    "di]", "di{", "di}", "di`", "x" }
for _, map in ipairs(ci_commands) do
    vim.api.nvim_set_keymap('n', map, '"_' .. map, { noremap = true })
end

-- Function to visually select a method/function in normal mode
local function select_method_visual()
    vim.cmd('normal! v[m]m')
end

-- Function to visually select a method/function in line mode
local function select_method_line_visual()
    vim.cmd('normal! V[m]m')
end

-- Function to delete inside a method/function
local function delete_method_inside()
    vim.cmd('normal! [m]md')
end

-- Function to delete around a method/function
local function delete_method_around()
    vim.cmd('normal! [m]md]m')
end

-- Function to yank inside a method/function
local function yank_method_inside()
    vim.cmd('normal! [m]my')
end

-- Function to yank around a method/function
local function yank_method_around()
    vim.cmd('normal! [m]my]m')
end

-- Map the functions to keys
vim.api.nvim_set_keymap('n', '<Leader>vim', ':lua select_method_visual()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>vam', ':lua select_method_line_visual()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dim', ':lua delete_method_inside()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dam', ':lua delete_method_around()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>yim', ':lua yank_method_inside()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>yam', ':lua yank_method_around()<CR>', { noremap = true, silent = true })

-- buffer management
-- vim.api.nvim_set_keymap('n', '<leader>bo', ':BufferCloseAllButCurrent<CR>', { noremap = true, silent = true })


-- setup lsp keymaps only when an lsp client attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>gu", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gu", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "d[", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "d]", vim.diagnostic.goto_next, opts)
    end
})

return {}

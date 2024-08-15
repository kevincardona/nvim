local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- project navigation
vim.keymap.set('n', '<leader>e', ":NvimTreeFindFileToggle!<CR>", opts)

-- normal mode navigation
vim.api.nvim_set_keymap('n', '<S-CR>', 'k^', opts)

-- remove highlights after search
vim.api.nvim_set_keymap('n', '<Esc>', ':nohlsearch<CR>', opts)

-- git
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', opts)
vim.keymap.set('n', '<leader>lc', ':LazyGitFilterCurrentFile<CR>', opts)

-- filepath copy
vim.keymap.set('n', '<leader>fa', ':let @+=expand("%:p")<CR>:echo "Copied absolute path: " . expand("%:p")<CR>',
    { noremap = true, silent = false })
vim.keymap.set('n', '<leader>fr', ':let @+=expand("%")<CR>:echo "Copied relative path: " . expand("%")<CR>',
    { noremap = true, silent = false })

-- window resize
vim.api.nvim_set_keymap('n', '<leader><Up>', ':resize +10<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Down>', ':resize -10<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Left>', ':vertical resize +20<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Right>', ':vertical resize -20<CR>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- autocomplete
vim.keymap.set('n', '<leader>ac', ':Copilot panel<CR>', opts)

-- setup lsp keymaps only when an lsp client attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
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
        vim.keymap.set('n', '<leader>af', vim.lsp.buf.format, opts)
        vim.keymap.set("n", "d[", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "d]", vim.diagnostic.goto_next, opts)
    end
})

return {}

local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- buffer navigation
vim.keymap.set('n', '<leader>bd', ':bd<CR>', opts)

-- project navigation
vim.keymap.set('n', '<leader>e', ":NvimTreeFindFileToggle!<CR>", opts)

-- buffer navigation
vim.keymap.set('n', '<leader>bd', ':bd<CR>', opts)

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

-- Keymap to copy the file itself to the clipboard (platform-specific)
-- vim.keymap.set('n', '<leader>fc', function()
--     local filepath = vim.fn.expand('%:p')
--     if vim.fn.has('mac') == 1 then
--         -- macOS command to copy file to clipboard
--         vim.cmd('silent !osascript -e \'set the clipboard to POSIX file "' .. filepath .. '"\'')
--         print('Copied file to clipboard: ' .. filepath)
--     elseif vim.fn.has('unix') == 1 then
--         -- Linux: Use xclip or wl-copy depending on the system
--         local clipboard_cmd = vim.fn.executable('xclip') == 1 and 'xclip -sel clip -t text/uri-list' or
--                               (vim.fn.executable('wl-copy') == 1 and 'wl-copy')
--
--         if clipboard_cmd ~= '' then
--             vim.cmd('silent !echo ' .. vim.fn.shellescape('file://' .. filepath) .. ' | ' .. clipboard_cmd)
--             print('Copied file to clipboard: ' .. filepath)
--         else
--             print('Clipboard command not found (xclip or wl-copy)')
--         end
--     else
--         print('Unsupported platform for file copy')
--     end
-- end, { noremap = true, silent = true })

-- window resize
vim.api.nvim_set_keymap('n', '<leader><Up>', ':resize +10<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Down>', ':resize -10<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Left>', ':vertical resize +20<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Right>', ':vertical resize -20<CR>', opts)

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix toggle
local function toggle_quickfix()
 local wins = vim.fn.getwininfo()
 local qf_exists = false
 
 for _, win in pairs(wins) do
   if win.quickfix == 1 then
     qf_exists = true
     break
   end
 end

 if qf_exists then
   vim.cmd('cclose') 
 else
   vim.cmd('copen')
 end
end

vim.keymap.set('n', '<leader>qf', toggle_quickfix, {silent = true})


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

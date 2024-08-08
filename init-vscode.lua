-- init_vscode.lua

-- Set a global variable to detect when running inside VS Code
vim.g.vscode = true

-- Source the primary init.lua
dofile(vim.fn.stdpath('config') .. '/init.lua')

-- keyboard shortcuts specific for vscode nvim
local function map_vscode_command(key, command, options)
  vim.keymap.set('n', key, string.format('<Cmd>lua require("vscode").call("%s")<CR>', command), options)
end

local opts = { noremap = true, silent = true }

vim.keymap.del('n', '<leader>e')
vim.keymap.del('n', '<leader>bo')

map_vscode_command('<leader>e', 'workbench.action.toggleSidebarVisibility', opts)
map_vscode_command('<leader>bo', 'workbench.action.closeOtherEditors', opts)
map_vscode_command('<leader>gu', 'editor.action.referenceSearch.trigger', opts)
map_vscode_command('gu', 'editor.action.referenceSearch.trigger', opts)


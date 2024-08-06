-- init_vscode.lua

-- Set a global variable to detect when running inside VS Code
vim.g.vscode = true

-- Source the primary init.lua
dofile(vim.fn.stdpath('config') .. '/init.lua')

-- keyboard shortcuts specific for vscode nvim
vim.keymap.del('n', '<leader>e')
vim.keymap.set('n', '<leader>e', '<Cmd>lua require("vscode").call("workbench.action.toggleSidebarVisibility")<CR>', { noremap = true, silent = true })

vim.keymap.del('n', '<leader>bo')
vim.keymap.set('n', '<leader>bo', '<Cmd>lua require("vscode").call("workbench.action.closeOtherEditors")<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gu', '<Cmd>lua require("vscode").call("editor.action.referenceSearch.trigger")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gu', '<Cmd>lua require("vscode").call("editor.action.referenceSearch.trigger")<CR>', { noremap = true, silent = true })


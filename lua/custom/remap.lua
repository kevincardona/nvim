local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)

-- project navigation
vim.api.nvim_set_keymap('n', '<leader>pm', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})

-- file navigation

 
vim.api.nvim_set_keymap('n', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>nn', ':lua require("harpoon.ui").nav_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bb', ':lua require("harpoon.ui").nav_prev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', {noremap = true, silent = true})


-- prevent yank on delete
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('n', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('v', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true})
vim.api.nvim_set_keymap('n', 'X', '"_X', {noremap = true})

-- for 'change inside' or 'delete inside' operations
local ci_commands = { 'ci"', "ci'", "ci(", "ci)", "ci[", "ci]", "ci{", "ci}", "ci`", "di'", 'di"', "di(", "di)", "di[", "di]", "di{", "di}", "di`" }
for _, map in ipairs(ci_commands) do
  vim.api.nvim_set_keymap('n', map, '"_' .. map, {noremap = true})
end

return {}


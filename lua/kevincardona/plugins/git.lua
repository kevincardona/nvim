local function open_git_ignore()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root == nil or git_root == '' then
    vim.api.nvim_err_writeln('Not a git repository (or any parent up to mount point /)')
    return
  end

  local git_exclude_path = git_root .. '/.gitignore'
  vim.cmd('split ' .. git_exclude_path)
end

local function open_git_exclude()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root == nil or git_root == '' then
    vim.api.nvim_err_writeln('Not a git repository (or any parent up to mount point /)')
    return
  end

  local git_exclude_path = git_root .. '/.git/info/exclude'
  vim.cmd('split ' .. git_exclude_path)
end


vim.api.nvim_create_user_command('GitExclude', open_git_exclude, {})
vim.keymap.set('n', '<leader>gte', ':GitExclude<CR>', { noremap = true, silent = true })
vim.api.nvim_create_user_command('GitIgnore', open_git_ignore, {})
vim.keymap.set('n', '<leader>gti', ':GitIgnore<CR>', { noremap = true, silent = true })

return {}

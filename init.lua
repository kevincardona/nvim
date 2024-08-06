-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager if not already installed ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('kevincardona')

-- Disable built-in NetRW plugin
vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1

-- Basic settings
vim.opt.conceallevel = 1
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 1
vim.wo.number = true                   -- Enable line numbers
vim.wo.rnu = true                      -- Enable relative line numbers
vim.o.mouse = 'a'                      -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- Sync with OS clipboard
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching
vim.o.smartcase = true                 -- ... unless there's a capital letter in the search
vim.wo.signcolumn = 'yes'              -- Always show the sign column
vim.o.updatetime = 250                 -- Decrease update time
vim.o.timeoutlen = 300                 -- Faster key sequence timeouts
vim.o.completeopt = 'menuone,noselect' -- Better completion experience
vim.o.termguicolors = true             -- True color support

-- Highlight search dynamically
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")

-- Highlight text on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

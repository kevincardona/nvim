-- includes all the plugins that are loaded without configuration + plugins included in ./plugins
require("lazy").setup({
    -- colors or something
    'folke/tokyonight.nvim',
    -- gcc to quickly comment out a line
    -- 'tpope/vim-commentary',
    'numToStr/Comment.nvim',
    -- quick change surrounding characters with cs
    'tpope/vim-surround',
    -- identify the indentation of a file
    'tpope/vim-sleuth',
    -- quick change from snake_case to camelCase and vise versa
    'tpope/vim-abolish',
    -- naturally switch between vim and tmux panes
    'christoomey/vim-tmux-navigator',
    -- quickly change surrounding characters with cs
    "tpope/vim-surround",
    { import = 'kevincardona.plugins' },
})

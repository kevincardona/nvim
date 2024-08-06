return {
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        config = function()
            vim.api.nvim_set_keymap('n', '<m-o>', ':lua require("nvim-navbuddy").open()<CR>', { noremap = true, silent = true })
            require("nvim-navbuddy").setup({
                lsp = { auto_attach = true },
            })
        end
    }
}


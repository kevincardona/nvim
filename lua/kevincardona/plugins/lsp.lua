return {
    -- GitHub Copilot
    'github/copilot.vim',

    -- LSP Configuration and Dependencies
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",                  -- Completion framework
            "williamboman/mason.nvim",           -- LSP/DAP Installer
            "williamboman/mason-lspconfig.nvim", -- Mason LSP bridge
            "j-hui/fidget.nvim",                 -- Notifications and LSP Progress

        },
        config = function()
            -- Setup Mason
            require("mason").setup()

            -- Setup Mason-LSPConfig
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "pyright" }, -- Add the LSPs you need
            })

            -- Load Blink CMP LSP Capabilities
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Setup Fidget
            require("fidget").setup({})

            -- Setup LSP Handlers via Mason-LSPConfig
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,
            })

            -- Diagnostics Configuration
            vim.diagnostic.config({
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                },
            })
        end,
    },
}

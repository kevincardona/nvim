if vim.g.vscode then
    return {}
end

return {
    -- GitHub Copilot
    'github/copilot.vim',

    -- LSP Configuration and Dependencies
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",                  -- Completion framework
            "j-hui/fidget.nvim",                 -- Notifications and LSP Progress
            { "mason-org/mason.nvim", version = "^1.0.0" },
            { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
        },
        config = function()
            -- Setup Mason
            require("mason").setup()

            -- Setup Mason-LSPConfig
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "pyright" }, -- Add the LSPs you need
            })


            -- Load Blink CMP LSP Capabilities
            require("blink.cmp").disable_fuzzy = true

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
                ["solargraph"] = function()
                    require("lspconfig").solargraph.setup({
                        capabilities = capabilities,
                        settings = {
                            solargraph = {
                                diagnostics = true,
                                completion = true,
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

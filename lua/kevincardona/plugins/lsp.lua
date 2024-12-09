if vim.g.vscode then
    return {}
end

return {
    'github/copilot.vim',
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    -- nvim-ts-autotag setup with custom configuration
                    require('nvim-ts-autotag').setup({
                        opts = {
                            enable_close = true,          -- Auto close tags
                            enable_rename = true,         -- Auto rename pairs of tags
                            enable_close_on_slash = false -- Do not auto close on trailing </
                        },
                        per_filetype = {
                            ["html"] = {
                                enable_close = false -- Disable auto-closing for HTML
                            }
                        }
                    })
                end
            }
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp = require('cmp')
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = { exclude = { "typos_lsp" } },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["solargraph"] = function()
                        lspconfig.solargraph.setup {
                            cmd = {
                                "asdf",
                                "exec",
                                "solargraph",
                                "stdio"
                            },
                            -- capabilities = capabilities,
                            settings = {
                                solargraph = {
                                    autoformat = false,
                                    formatting = false,
                                    completion = true,
                                    diagnostic = true,
                                    folding = true,
                                    references = true,
                                    rename = true,
                                    symbols = true
                                }
                            }
                            -- You might need to customize the command path if solargraph is not found
                            -- cmd = { "path/to/your/asdf/ruby/bin/solargraph", "stdio" },
                        }
                    end,

                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,

                    ["tsserver"] = function()
                        lspconfig.tsserver.setup {
                            capabilities = capabilities,
                            handlers = {
                                ["textDocument/publishDiagnostics"] = function() end
                            }
                        }
                    end,
                }
            })

            lspconfig.gdscript.setup(capabilities)

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
}

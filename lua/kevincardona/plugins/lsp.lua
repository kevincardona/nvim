if vim.g.vscode then
    return {}
end

-- will probably want to add rvm_silence_path_mismatch_check_flag=1 to your ~/.rvmrc file to prevent errors if nvm is installed
local function setup_solargraph()
    local home = os.getenv("HOME")
    local handle = io.popen("rvm current")
    local rvm_current_output = handle:read("*a")
    handle:close()

    if not rvm_current_output then
        vim.notify("Failed to retrieve current RVM version", vim.log.levels.ERROR)
        return
    end

    local ruby_version = rvm_current_output:gsub("\n", "")
    if ruby_version == "" then
        vim.notify("RVM returned an empty Ruby version", vim.log.levels.ERROR)
        return
    end

    local solargraph_cmd = home .. "/.rvm/gems/" .. ruby_version .. "/bin/solargraph"
    require("lspconfig").solargraph.setup {
        cmd = { solargraph_cmd, "stdio" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        -- Additional Solargraph configuration options can be added here
    }
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
        },

        config = function()
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
                automatic_installation = { exclude = { "typos_lsp", "solargraph" } },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
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
                }
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "ruby",
                callback = function()
                    local active_clients = vim.lsp.get_active_clients()
                    local client_found = false

                    for _, client in ipairs(active_clients) do
                        if client.name == "solargraph" then
                            client_found = true
                            break
                        end
                    end

                    if not client_found then
                        setup_solargraph()
                    end
                end,
            })

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
                    focusable = false,
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

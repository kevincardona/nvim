return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = '|',
            section_separators = '',
            cmdheight = 0
        },
        sections = {
            lualine_a = {},
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filename', file_status = true, path = 1 },
            },
            lualine_x = {
                'location',
                {
                    -- Custom function to list active LSPs
                    function()
                        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                        if next(clients) == nil then
                            return '' -- No LSP attached
                        end
                        local lsp_names = {}
                        for _, client in ipairs(clients) do
                            -- Filter out Copilot
                            if client.name ~= "GitHub Copilot" then
                                table.insert(lsp_names, client.name)
                            end
                        end
                        if #lsp_names == 0 then
                            return '' -- No other LSPs attached
                        end
                        return ' ' .. table.concat(lsp_names, ', ')
                    end,
                    icon = '', -- Optional icon for LSP
                },
            },
            lualine_y = { function() return os.date("%r") end, },
            lualine_z = {}
        },
    },
}

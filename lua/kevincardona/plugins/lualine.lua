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
            lualine_x = { 'location' },
            lualine_y = { function() return os.date("%r") end, },
            lualine_z = {}
        },
    },
}

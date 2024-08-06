-- theme of nvim
return {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
        require('onedark').setup {
            style = 'darker',     -- dark, darker, cool, deep, warm, warmer, light
        }
        require('onedark').load()
    end,
}

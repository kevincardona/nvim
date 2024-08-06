return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
        local toggle_fold_column = function()
            local foldcolumn = vim.wo.foldcolumn
            if foldcolumn == '1' then
                vim.wo.foldcolumn = '0'
            else
                vim.wo.foldcolumn = '1'
            end
        end

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1'
        vim.keymap.set("n", "<leader>fo", ":foldopen<CR>")
        vim.keymap.set("n", "<leader>fc", ":foldclose<CR>")
        vim.keymap.set("n", "<leader>fi", ":foldclose<CR>")
        vim.keymap.set('n', '<leader>fO', require('ufo').openAllFolds)
        vim.keymap.set('n', '<leader>fC', require('ufo').closeAllFolds)
        vim.keymap.set('n', '<leader>fI', require('ufo').closeAllFolds)
        vim.keymap.set('n', '<leader>fh', toggle_fold_column)
    end
}

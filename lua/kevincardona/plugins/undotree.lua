if vim.g.vscode then
    return {}
end

-- keeps a history of changes to the file to undo/redo
return {
    'mbbill/undotree',

    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
}

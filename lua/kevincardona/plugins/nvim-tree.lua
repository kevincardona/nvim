if vim.g.vscode then
    return {}
end

-- file explorer because i dont like ex
return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local function focus_next_buffer_if_nvim_tree()
                local bufnr = vim.api.nvim_get_current_buf()
                if vim.bo[bufnr].filetype == 'NvimTree' then
                    vim.cmd('wincmd l')
                end
            end

            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                vim.keymap.set('n', '<C-o>', function()
                    focus_next_buffer_if_nvim_tree()
                    vim.cmd('normal! <C-o>')
                end, opts('Conditional Jump Back'))

                vim.keymap.set('n', '<C-i>', function()
                    focus_next_buffer_if_nvim_tree()
                    vim.cmd('normal! <C-i>')
                end, opts('Conditional Jump Forward'))

                vim.g.nvim_tree_auto_close = 1

                vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
                vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
                vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
                vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
                vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
                vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
                vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
                vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
                vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts('Trash Bookmarked'))
                vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
                vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
                vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
                vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
                vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
                vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
                vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
                vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
                vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
                vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
                vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
                vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
                vim.keymap.set('n', 'ge', api.fs.copy.basename, opts('Copy Basename'))
                vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
                vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
                vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
                vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
                vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
                vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
                vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
                vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
                vim.keymap.set('n', 'u', api.fs.rename_full, opts('Rename: Full Path'))
                vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
                vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
                vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
                vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
                vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    adaptive_size = true
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                update_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                actions = {
                    change_dir = { enable = false }
                },
            })
        end
    }
}

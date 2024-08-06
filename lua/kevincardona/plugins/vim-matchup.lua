if vim.g.vscode then
  return {}
end

return {
  'andymass/vim-matchup',
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end
}

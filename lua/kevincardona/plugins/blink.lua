return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = "v0.*",
  build = 'cargo build --release',
  opts = {
    keymap = {
      preset = 'default',                         -- Use default mappings as the base
      ['<Up>'] = { 'select_prev', 'fallback' },   -- Navigate up
      ['<Down>'] = { 'select_next', 'fallback' }, -- Navigate down
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    signature = { enabled = true },
  },
}

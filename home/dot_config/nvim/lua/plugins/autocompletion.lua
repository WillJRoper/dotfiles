return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { score_offset = 0 },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}

return {
  "saghen/blink.cmp",
  version = "1.*", -- pulls the prebuilt Rust fuzzy-matcher; v1 = stable
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" }, -- matches your font
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- float lazydev results to the top
        },
      },
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true, window = { border = "rounded" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "catppuccin-mocha",
      icons_enabled = vim.g.have_nerd_font,
      globalstatus = true,
    },
  },
}

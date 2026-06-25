return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        telescope = { enabled = true },
        which_key = true,
        gitsigns = true,
        mason = true,
        blink_cmp = true,
        mini = { enabled = true },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

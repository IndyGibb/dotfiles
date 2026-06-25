return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 0, -- show the menu instantly on a prefix; then waits for you
    icons = {
      mappings = vim.g.have_nerd_font,
    },
    spec = {
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "[H]unk" },
      { "<leader>d", group = "[D]ebug" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer-local keymaps",
    },
  },
}

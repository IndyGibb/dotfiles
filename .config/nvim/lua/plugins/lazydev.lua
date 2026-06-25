return {
  "folke/lazydev.nvim",
  ft = "lua", -- only loads when editing Lua
  opts = {
    library = {
      -- adds vim.uv (luv) types when it sees 'vim.uv' in a file
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

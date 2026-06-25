return {
  "nvim-mini/mini.nvim",
  config = function()
    -- Better around/inside text objects
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surrounding delimiters
    require("mini.surround").setup()
  end,
}

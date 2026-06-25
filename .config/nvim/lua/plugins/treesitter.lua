return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- main branch does NOT support lazy-loading
  build = ":TSUpdate", -- keep parsers in sync with the plugin
  config = function()
    require("nvim-treesitter").setup()

    -- Parsers to compile (your stack + nvim config essentials)
    require("nvim-treesitter").install({
      "lua", "luadoc", "vim", "vimdoc", "query",
      "python", "c", "cpp",
      "bash", "markdown", "markdown_inline", 
      "json", "yaml", "toml", "diff", "gitcommit",
    })

    -- Highlighting is NOT autommatic on the main branch - enable it
    -- per-buffer wherever a parser exists. pcall swallows the error
    -- for filetypes with no parser, so this is self-maintaining.
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Enable Treesitter highlighting",
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}

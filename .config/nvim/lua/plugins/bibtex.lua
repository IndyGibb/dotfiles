return {
  "nvim-telescope/telescope-bibtex.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  ft = "markdown",
  config = function()
    require("telescope").setup({
      extensions = {
        bibtex = {
          global_files = { vim.fn.expand("~/notes/refs/library.bib") },
          custom_formats = {
            { id = "pandoc_bracket", cite_marker = "[@%s]" },
          },
          format = "pandoc_bracket",
          citation_format = "{{author}} ({{year}}), {{title}}.",
          citation_trim_firstname = true,
          citation_max_auth = 2,
          context = true,
          context_fallback = true,
          search_keys = { "author", "year", "title" },
          wrap = true,
          depth = 1,
        },
      },
    })
    require("telescope").load_extension("bibtex")
  end,
}

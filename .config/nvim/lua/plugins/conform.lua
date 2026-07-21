return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- load just before the first save
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      markdown = { "markdownlint-cli2" },
    },
    format_on_save = function(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name:match("%.excalidraw%.md$") then
        return nil
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  },
}

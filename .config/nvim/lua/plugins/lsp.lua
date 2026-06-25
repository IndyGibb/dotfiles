return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local diagnostic_icons = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    }
    -- Diagnostics appearance (plain letters now; prettier icons later)
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = true },
      signs = { text = diagnostic_icons },
      virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = function(diagnostic)
          return diagnostic_icons[diagnostic.severity] .. " "
        end,
      },
    })

    -- Per-server overrides; defaults come from nvim-lspconfig.
    -- lazydev will ad the nvim runtime library next; for now this
    -- silences the 'vim' global and uses snippet-style completion.
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportUnusedImport = "none",
              reportUnusedVariable = "none",
              reportUnusedExpression = "none",
              reportUndefinedVariable = "none",
            },
          },
        },
      },
    })

    -- Install + auto-enable servers
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "basedpyright", "ruff", "clangd" },
      automatic_enable = true,
    })

    -- Buffer-local keymaps once a server attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP keymaps",
      callback = function(args)
        local buf = args.buf
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("<leader>e", vim.diagnostic.open_float, "Show line diagnostic")

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            local on = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
            vim.lsp.inlay_hint.enable(not on, { bufnr = buf })
          end, "Toggle inlay hints")
        end
      end,
    })
  end,
}

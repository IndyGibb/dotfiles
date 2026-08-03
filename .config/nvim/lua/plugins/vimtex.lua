return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- Ensure .tex is treated as LaTeX rather than plain TeX. VimTeX does
      -- this itself unless tex_flavor says otherwise; setting it is explicit.
      vim.g.tex_flavor = "latex"

      vim.g.vimtex_view_method = "zathura_simple"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_indent_enabled = 1

      -- Conceal settings MUST be set before VimTeX loads. vimtex#options#init()
      -- merges these with its defaults exactly once, via extend_recursive with
      -- 'keep'. Setting them later replaces the dictionary outright and the
      -- syntax script errors on the missing keys (E716).
      vim.g.vimtex_syntax_conceal = {
        sections = 1, -- \section{X} renders as "# X"
        -- math_symbols = 0,  -- uncomment if the symbol replacements are too much
      }
      vim.g.vimtex_syntax_conceal_cites = {
        type = "brackets", -- \cite{Knuth1981} renders as [Knuth1981]
        verbose = 0,
      }

      -- VimTeX's FAQ strongly advises disabling treesitter highlighting for
      -- LaTeX: the math text objects (i$/a$) resolve regions via syntax
      -- groups, and treesitter highlighting cannot conceal.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex" },
        callback = function()
          pcall(vim.treesitter.stop)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function(ev)
          local b = ev.buf

          -- Buffer-local, so markdown/json conceal behaviour is untouched.
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = ""

          -- Discoverable aliases for the ds/cs/ts family. The originals still
          -- work; these exist so the mappings appear in which-key, which shows
          -- operator-pending motions after `d` rather than VimTeX's normal-mode maps.
          local function map(lhs, plug, desc)
            vim.keymap.set(
              { "n", "x" },
              "<localleader>lw" .. lhs,
              "<Plug>(vimtex-" .. plug .. ")",
              { buffer = b, remap = true, desc = desc }
            )
          end

          map("e", "env-change", "Change [e]nvironment")
          map("E", "env-delete", "Delete [E]nvironment")
          map("c", "cmd-change", "Change [c]ommand")
          map("C", "cmd-delete", "Delete [C]ommand")
          map("d", "delim-change-math", "Change [d]elimiter")
          map("D", "delim-delete", "Delete [D]elimiter")
          map("f", "cmd-toggle-frac", "Toggle [f]raction")
          map("m", "env-toggle-math", "Toggle inline/display [m]ath")
          map("b", "cmd-toggle-break", "Toggle line [b]reak")
          map("s", "cmd-toggle-star", "Toggle [s]tarred command")
          map("S", "env-toggle-star", "Toggle [S]tarred environment")
          map("t", "env-toggle", "[T]oggle environment type")
          map("l", "delim-toggle-modifier", "Toggle \\[l]eft / \\right")

          local ok, wk = pcall(require, "which-key")
          if not ok then
            return
          end
          wk.add({
            { "<localleader>l", group = "[L]aTeX", buffer = b },
            { "<localleader>lw", group = "[W]rap & surround", buffer = b },
            { "<localleader>ll", desc = "Compi[l]e (toggle)", buffer = b },
            { "<localleader>lL", desc = "Compi[L]e selection", buffer = b, mode = { "n", "x" } },
            { "<localleader>lS", desc = "Compile [S]ingle shot", buffer = b },
            { "<localleader>lk", desc = "[K]ill compile", buffer = b },
            { "<localleader>lK", desc = "[K]ill all compiles", buffer = b },
            { "<localleader>lv", desc = "[V]iew PDF", buffer = b },
            { "<localleader>lr", desc = "[R]everse search", buffer = b },
            { "<localleader>le", desc = "[E]rrors", buffer = b },
            { "<localleader>lq", desc = "Compiler log", buffer = b },
            { "<localleader>lo", desc = "Compile [o]utput", buffer = b },
            { "<localleader>lg", desc = "Status", buffer = b },
            { "<localleader>lG", desc = "Status (all projects)", buffer = b },
            { "<localleader>lt", desc = "[T]able of contents", buffer = b },
            { "<localleader>lT", desc = "[T]oggle contents pane", buffer = b },
            { "<localleader>lc", desc = "[C]lean aux files", buffer = b },
            { "<localleader>lC", desc = "[C]lean all output", buffer = b },
            { "<localleader>lm", desc = "List insert [m]aps", buffer = b },
            { "<localleader>la", desc = "[A]ctions menu", buffer = b },
            { "<localleader>li", desc = "Project [i]nfo", buffer = b },
            { "<localleader>lI", desc = "Full project [I]nfo", buffer = b },
            { "<localleader>ls", desc = "[S]witch main file", buffer = b },
            { "<localleader>lx", desc = "Reload VimTe[x]", buffer = b },
            { "<localleader>lX", desc = "Reload state", buffer = b },
          })
        end,
      })
    end,
  },
}

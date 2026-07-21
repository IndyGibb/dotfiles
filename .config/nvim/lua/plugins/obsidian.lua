return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/notes/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },

    notes_subdir = nil,
    new_notes_location = "current_dir",

    daily_notes = {
      folder = "Journal/Daily",
      date_format = "%Y-%m-%d",
      template = "Daily Note Template.md",
    },

    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    attachments = {
      folder = "Attachments",
    },

    picker = {
      name = "telescope.nvim",
    },

    ui = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    local vault = vim.fn.expand("~/notes")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = vault .. "/*.md",
      callback = function(args)
        local buf = args.buf
        local function map(lhs, rhs, desc, mode)
          vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = desc })
        end
        map("<leader>oo", "<cmd>Obsidian quick_switch<cr>", "[O]pen note")
        map("<leader>os", "<cmd>Obsidian search<cr>", "[S]earch notes")
        map("<leader>on", "<cmd>Obsidian new<cr>", "[N]ew note")
        map("<leader>ot", "<cmd>Obsidian new_from_template<cr>", "New from [T]emplate")
        map("<leader>ob", "<cmd>Obsidian backlinks<cr>", "[B]acklinks")
        map("<leader>ol", "<cmd>Obsidian links<cr>", "[L]inks in note")
        map("<leader>og", "<cmd>Obsidian tags<cr>", "Ta[g]s")
        map("<leader>od", "<cmd>Obsidian today<cr>", "[D]aily note")
        map("<leader>oy", "<cmd>Obsidian yesterday<cr>", "[Y]esterday")
        map("<leader>oD", "<cmd>Obsidian dailies<cr>", "[D]ailies picker")
        map("<leader>op", "<cmd>Obsidian paste_img<cr>", "[P]aste image")
        map("<leader>or", "<cmd>Obsidian rename<cr>", "[R]ename note")
        map("<leader>oi", "<cmd>Obsidian template<cr>", "[I]nsert template")
        map("<leader>oe", "<cmd>Obsidian extract_note<cr>", "[E]xtract to new note", "v")
        map("<leader>ok", "<cmd>Obsidian link<cr>", "Lin[k] selection", "v")

        local ok, wk = pcall(require, "which-key")
        if ok then
          wk.add({ { "<leader>o", group = "[O]bsidian", buffer = buf } })
        end
      end,
    })
  end,
}

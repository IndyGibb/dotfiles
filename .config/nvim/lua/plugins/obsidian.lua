local function long_date()
  local d = tonumber(os.date("%d"))
  local suffix = "th"
  if d % 10 == 1 and d ~= 11 then
    suffix = "st"
  elseif d % 10 == 2 and d ~= 12 then
    suffix = "nd"
  elseif d % 10 == 3 and d ~= 13 then
    suffix = "rd"
  end
  return os.date("%A ") .. d .. suffix .. os.date(" %B %Y %H%M")
end
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
    frontmatter = {
      enabled = false,
    },
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
      substitutions = {
        long_date = long_date,
      },
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

    note_id_func = function(title)
      if title ~= nil then
        return title
      end
      return tostring(os.time())
    end,
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
        map("<leader>on", "<cmd>Obsidian new_from_template Neovim Default<cr>", "[N]ew note")
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
        map("<leader>oc", "<cmd>Telescope bibtex<cr>", "[C]ite")

        local ok, wk = pcall(require, "which-key")
        if ok then
          wk.add({ { "<leader>o", group = "[O]bsidian", buffer = buf } })
        end
      end,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = vault .. "/*.md",
      callback = function(args)
        local buf = args.buf
        local lines = vim.api.nvim_buf_get_lines(buf, 0, 15, false)
        for i, line in ipairs(lines) do
          if line:match("^Last modified:") then
            local new = "Last modified: " .. long_date()
            if line ~= new then
              vim.api.nvim_buf_set_lines(buf, i - 1, i, false, { new })
            end
            return
          end
        end
      end,
    })
  end,
}

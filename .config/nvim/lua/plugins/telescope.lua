return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
    map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    map("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
    map("n", "<leader><leader>", builtin.buffers, { desc = "Find buffers" })
    map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search buffer" })
    map("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
  end,
}

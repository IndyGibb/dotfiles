-- Leader keys MUST be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- We have a Nerd Font (DepartureMono Nerd Font)
vim.g.have_nerd_font = true

-- Core editor config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

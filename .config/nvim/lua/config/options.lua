local opt = vim.opt

opt.number = true -- absolute line numbers
opt.relativenumber = true -- relative for easy j/k jumps
opt.mouse = "" -- mouse disabled
opt.showmode = false -- lualine shows the mode

opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.breakindent = true -- wrapped lines keep indent
opt.undofile = true -- persistent undo across sessions

opt.ignorecase = true -- case-insensitive search...
opt.smartcase = true -- ...unless a capital is typed

opt.signcolumn = "yes" -- always show sign column
opt.updatetime = 250 -- faster CursorHold / diagnostics
opt.timeoutlen = 500 -- mapped-sequence wait (ms)

opt.splitright = true -- vertical splits open right
opt.splitbelow = true -- horizontal splits open below

opt.list = true -- show invisible chars
opt.listchars = { tab = "» ", trail = "·", nbsp = "¬" }

opt.inccommand = "split" -- live preview of :substitute
opt.cursorline = true -- highlight current line
opt.scrolloff = 10 -- keep 10 lines above/below cursor
opt.confirm = true -- prompt instead of failing on q
opt.termguicolors = true -- 24-bit color (foot supports it)

opt.tabstop = 2 -- how wide a literal tab character displays
opt.shiftwidth = 2 -- indent width for >>, <<, and autoindent
opt.softtabstop = 2 -- how many columns the Tab key inserts
opt.expandtab = true -- insert spaces instead of tab characters

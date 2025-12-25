-- ~/.config/nvim/init.lua
-- only require here pls
-- relative numbers
vim.opt.number = true
vim.opt.rnu = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- PWSH
-- ... inne ustawienia Vima (vim.opt)
-- Załaduj konfigurację LazyVim z osobnego pliku

require("config.settings")
require("config.keymaps")
--require("config.terminal")
require("config.lazy")
require("config.ui").setup()

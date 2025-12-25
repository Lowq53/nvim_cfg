-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\init.luy
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
require("config.lazy")
require("keymaps")
--require("config.terminal")
require("config.ui").setup()

-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\init.luy
-- ~/.config/nvim/init.lua
-- only require here pls
-- relative numbers
vim.opt.number = true
vim.opt.rnu = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- chunk-level tylko w tym pliku
-- local vks = vim.keympap.set
-- PWSH
-- ... inne ustawienia Vima (vim.opt)
-- Załaduj konfigurację LazyVim z osobnego pliku

require("config.settings")
require("keymaps")
require("config.lazy")
--require("config.terminal")
require("config.ui").setup()

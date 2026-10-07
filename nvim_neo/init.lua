--Package.path = package.path .. ";C:/Users/LOWq_53/AppData/Local/nvim-lowq53/lua/?.lui;C:/Users/LOWq_53/AppData/Local/nvim-lowq53/lua/?/init.lua"

vim.g.mapleader = "\\"
vim.g.maplocalleader = ""
vim.opt.termguicolors = true
vim.opt.background = "dark"


require("settings")
require("config.lazy")
require("keymaps")
require("config.ui")()
--require("plugins")
-- print("Lowq53 config!yrba")

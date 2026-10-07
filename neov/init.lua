-- ~/.config/nvim/init.lua
vim.env.VIMRUNTIME = 'C:\\dev\\nvimdev\\nvim_0.11.5\\neovim-source\\runtime\\'
-- only require here pls
-- relative numbers
vim.opt.number = true
vim.opt.rnu = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- ... inne ustawienia Vima (vim.opt)

-- Załaduj konfigurację LazyVim z osobnego pliku

require("config.settings")
-- require("config.keymaps")
require("config.lazy")
require("config.ui2")
--  setting up own colorcheme
vim.cmd.colorscheme("tokyonight")
vim.schedule(function()
	_G.set_transparency()
	_G.set_custom_syntax_colors()
end)


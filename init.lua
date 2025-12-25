-- ~/.config/nvim/init.lua
-- only require here pls
-- relative numbers

-- PWSH
-- ... inne ustawienia Vima (vim.opt)
-- Załaduj konfigurację LazyVim z osobnego pliku

require('settings')
require('keymaps')
require('commands')
-- require("config.keymaps")
--require("config.terminal")
--require("config.lazy")
-- require("config.ui2")()
--  setting up own colorcheme
-- vim.cmd.colorscheme("tokyonight")
-- vim.schedule(function()
--	_G.set_transparency()
--	_G.set_custom_syntax_colors()
-- end)

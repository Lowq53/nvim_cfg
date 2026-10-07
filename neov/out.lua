-- bundle 2026-10-07 20:07 from C:\Users\LOWq_53\AppData\Local\nvim_cfg\neov

package.preload["config.lazy"] = function(...)
-- Bootstrap lazy.nvim

-- https://github.com/folke/lazy.nvim
-- https://lazy.folke.io/installation
-- Bootstrap lazy.nvim
--
--
-- In your init.lua
-- vim.cmd.colorscheme("tokyonight")
vim.opt.termguicolors = true
vim.opt.background = "dark"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	rocks = {
		enabled = true,
		hererocks = true,
	},
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = true, -- get a notification when changes are found
	},
	install = { colorscheme = { "tolkyonight" } },
})

-- CTRL+C closes Lazy popup
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	callback = function()
		vim.keymap.set("n", "<C-c>", "<cmd>q<cr>", { buffer = true, silent = true })
	end,
})

vim.defer_fn(function()
	if vim.fn.argc() == 0 then
		local ok, lazy = pcall(require, "lazy")
		if ok then
			lazy.show()
		end
	end
end, 100)

-- q          zamknij okno Lazy
-- <CR>       otwórz szczegóły pluginu
-- u          update pojedynczego pluginu
-- U          update wszystkich pluginów
-- s          sync (install + update + clean)
-- i          install pluginu
-- x          clean nieużywanych pluginów
-- c          check aktualizacji
-- r          retry failed
-- g          pokaż git diff / historię
-- K          pomoc (help)
-- H          toggle panelu help

-- Ctrl+C    zamknij okno Lazy

end

package.preload["config.settings"] = function(...)
-- lua/config/settings.lua
return function()
  vim.opt.termguicolors = true
  vim.opt.background = "dark"

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.mouse = "a"
  vim.opt.clipboard = "unnamedplus"

  vim.opt.splitright = true
  vim.opt.splitbelow = true

  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true

  vim.opt.undofile = true
  vim.opt.swapfile = false
end

end

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


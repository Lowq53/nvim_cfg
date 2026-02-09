-- AppData/Local/nvim_cfg/nvim_dev/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. Mechanizm Auto-Bootstrap: Sprawd´ czy lazy istnieje, jeòli nie - sklonuj go

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

-- adding layz to runtimepath, that nvim should see it
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		-- place for plugins showcase
		-- [[
		-- { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
		-- { "neovim/nvim-lspconfig", dependencies = { "Saghen/blink.cmp" } },
		-- { "stevearc/oil.nvim", opts = {} },
		-- ]]
	},

	-- todo -- rozkminic luarocks
	-- ‚õî WY≈ÅƒÑCZ LUAROCKS / HEREROCKS (nie u≈ºywasz)
	rocks = {
		enabled = false,
	},
	-- DODANE: Wyøøcz auto-reload przy kaødej zmianie pliku
	change_detection = {
		enabled = false, -- Pozostaw wøøczone, ale...
		notify = false, -- ...wyøøcz powiadomienia (to usunie spam "Config Change Detected")
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates -- false --
	checker = { enabled = false },
})

-- Pro Tip dla Seniora: Jak wymusiƒá UI przy pierwszym starcie?
-- Je≈õli chcesz dok≈Çadnie zachowanie z kickstart (otwarcie okna po instalacji):

-- TO DO
-- - sprawdzic jak powinno sie uruchamiac lazy ja otwieram nvim
-- - jeseli bez pliku to sie pokazuje a jak plik to sie pokazuje plik nie lazy

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Sprawdzamy argumenty wiersza polece‰
		local has_args = vim.fn.argc() > 0
		-- Sprawdzamy, czy aktualny bufor ma przypisan• nazw© pliku
		local is_empty_buf = vim.api.nvim_buf_get_name(0) == ""
		-- Sprawdzamy typ bufora (czy to nie jest np. Dashboard)
		local is_normal_buf = vim.bo.buftype == ""

		-- Warunek: Otw¢rz Lazy tylko jeòli:
		-- Zostaà wymuszony przez instalacj© LUB (nie ma argument¢w I bufor jest pusty)
		if is_fresh_install or (not has_args and is_empty_buf and is_normal_buf) then
			require("lazy").show()
		end
	end,
})

-- Esc/Ctrl-C do zamykania okna lazy przez FileType autocmd
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	callback = function(event)
		vim.keymap.set("n", "<Esc>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = event.buf, nowait = true, silent = true })

		vim.keymap.set("n", "<C-c>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = event.buf, nowait = true, silent = true })
	end,
})
-- to jes pod \lc
-- -- Globalny skr√≥t <space>l do otwierania Lazy
-- vim.keymap.set("n", "<space>l", function()
--   require("lazy").show()
-- end)

-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\init.luy
-- ~/.config/nvim/init.lua
-- only require here pls

require("config.settings")
require("utils")
require("keymaps")
require("tmp.init")

-- lub jeśli używasz mingw32-make:
require("config.lazy")
--require("config.terminal")

require("config.pwsh")
vim.opt.clipboard = "unnamedplus"

-- vim.g.clipboard = {
--   name = "windows-clipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   paste = {
--     ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--     ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--   },
--   cache_enabled = 0,
-- }
--
-- need to check lualine evil_lualine is deleting by transparent backgorund in nvim dev
-- Wymuszenie przezroczystości na samym końcu ładowania
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy", -- Czeka, aż wszystkie pluginy się załadują
	callback = function()
		require("tokyonight").setup({ transparent = true })
		vim.cmd("colorscheme tokyonight")

		-- Dodatkowe "ubezpieczenie" - czyści tło ręcznie, gdyby plugin zawiódł
		local groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "NvimTreeNormal" }
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
})

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
-- Windows fixes
if vim.fn.has("win32") == 1 then
  -- cmd.exe musi istnieć i być używalny przez .cmd/.bat (npm, gem, itp.)
  vim.env.COMSPEC = "C:\\Windows\\System32\\cmd.exe"

  local function add_to_path(dir)
    local path = vim.env.PATH or ""
    if not path:lower():find(dir:lower(), 1, true) then
      vim.env.PATH = dir .. ";" .. path
    end
  end

  -- krytyczne dla chcp i masy narzędzi
  add_to_path("C:\\Windows\\System32")
  add_to_path("C:\\Windows")

  -- (opcjonalnie) jeśli masz 7-zip tu:
  -- add_to_path("F:\\Programs\\7-Zip")
end

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

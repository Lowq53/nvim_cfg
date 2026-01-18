--[[
FLOAT FOCUS / FLOAT OPACITY MANAGER

Cel:
- Ujednolica wygląd floating windows
- Zwiększa fokus przez przyciemnienie tła
- Działa tylko dla zainstalowanych pluginów
- Zero crashy, zero warunków wyścigu

Obsługiwane pluginy:
- Global float (NormalFloat)
- Telescope.nvim
- CopilotChat.nvim
- lazy.nvim

Konfiguracja:
- opacity_percent: 0–100
  0   = brak przezroczystości
  20  = sensowny fokus (rekomendowane)
  40+ = agresywne, męczące
--]]

local M = {}

-----------------------------------------------------------------------
-- KONFIGURACJA
-----------------------------------------------------------------------
M.opacity_percent = 10

-----------------------------------------------------------------------
-- UTILS
-----------------------------------------------------------------------
local function is_installed(name)
	local ok, _ = pcall(require, name)
	return ok
end

local function clamp(v, min, max)
	return math.max(min, math.min(max, v))
end

local function opacity_to_winblend(percent)
	percent = clamp(percent, 0, 100)
	return math.floor((percent / 100) * 30)
end

-----------------------------------------------------------------------
-- APPLY GLOBAL FLOAT STYLE
-----------------------------------------------------------------------
local function apply_global_float()
	local wb = opacity_to_winblend(M.opacity_percent)
	vim.opt.winblend = wb
	vim.opt.pumblend = wb
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0b0e14" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5c6370", bg = "#0b0e14" })
end

-----------------------------------------------------------------------
-- TELESCOPE
-----------------------------------------------------------------------
local function apply_telescope()
	if not is_installed("telescope") then
		return
	end

	local bg = "#080a10"
	local groups = {
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
	}

	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = bg })
	end
end

-----------------------------------------------------------------------
-- COPILOT CHAT
-----------------------------------------------------------------------
local function apply_copilot_chat()
	if not is_installed("CopilotChat") then
		return
	end

	vim.api.nvim_create_autocmd("WinNew", {
		callback = function()
			local win = vim.api.nvim_get_current_win()
			local cfg = vim.api.nvim_win_get_config(win)

			if cfg.relative == "" then
				return
			end

			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

			if ft ~= "copilot-chat" then
				return
			end

			-- Wyłącz transparency dla CopilotChat (lepiej widoczne)
			vim.api.nvim_win_set_option(win, "winblend", 0)

			-- Bazowa opacity + 20%
			local copilot_opacity = math.min(M.opacity_percent + 20, 100)
			vim.api.nvim_win_set_option(win, "winblend", opacity_to_winblend(copilot_opacity))

			vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = "#080a10" })
			vim.api.nvim_set_hl(0, "CopilotChatBackground", { bg = "#080a10" })
			vim.api.nvim_set_hl(0, "CopilotChatBorder", { bg = "#080a10", fg = "#5c6370" })
		end,
	})
end

-----------------------------------------------------------------------
-- LAZY.NVIM
-----------------------------------------------------------------------
local function apply_lazy()
	if not is_installed("lazy") then
		return
	end
	vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#05070c" })
end

-----------------------------------------------------------------------
-- INIT
-----------------------------------------------------------------------
function M.setup(opts)
	opts = opts or {}
	if opts.opacity then
		M.opacity_percent = opts.opacity
	end

	apply_global_float()
	apply_telescope()
	apply_copilot_chat()
	apply_lazy()
end

-----------------------------------------------------------------------
-- AUTO START
-----------------------------------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		M.setup()
		vim.api.nvim_set_hl(0, "LazyNormal", { link = "TelescopeNormal" })
		vim.api.nvim_set_hl(0, "LazyBorder", { link = "TelescopeBorder" })
	end,
})

vim.api.nvim_set_hl(0, "LazyNormal", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "LazyBorder", { link = "TelescopeBorder" })

M.setup()

return M

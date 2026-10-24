--c:/Users/LOWq_53/AppData/Local/nvim_dev/lua/config/ui.lua
local M = {}

local function apply_highlights()
	vim.opt.termguicolors = true
	vim.cmd.colorscheme("tokyonight-moon")

	local transparent_groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"Pmenu",
		"PmenuSel",
		"PmenuSbar",
		"PmenuThumb",
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewNormal",
		"WhichKeyFloat",
		"NvimTreeNormal",
		"NvimTreeNormalNC",
		"CmpPmenu",
		"NoicePopup",
		"MsgArea",
		"StatusLine",
		"StatusLineNC",
		"WinBar",
		"FoldColumn",
		"VertSplit",
		"WinSeparator",
		"SignColumn",
		"EndOfBuffer",
		"LazyNormal",
		"LazyButton",
		"LazyButtonActive",
		"LazyH1",
		"LazyH2",
		"LazySpecial",
		"LazyProp",
		"LazyValue",
		"LazyDir",
		"LazyUrl",
		"LazyCommit",
		"LazyNoCond",
		"LazyLocal",
	}

	for _, group in ipairs(transparent_groups) do
		pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE", ctermbg = "NONE" })
	end

	vim.api.nvim_set_hl(0, "Normal", { fg = "#d8dee9", bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "Comment", { fg = "#e5c07b", italic = true })
	vim.api.nvim_set_hl(0, "@comment", { fg = "#e5c07b", italic = true })
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#7c3b54", bold = true })
	vim.api.nvim_set_hl(0, "Function", { fg = "#8be9fd", bold = true })
	vim.api.nvim_set_hl(0, "String", { fg = "#a6e3a1" })
	vim.api.nvim_set_hl(0, "Number", { fg = "#fab387" })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#f2cdcd" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#d65a31" })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#ff8c42", bold = false })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ff8c42", bold = file })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff4500", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "Cursor", { fg = "#0f111a", bg = "#f38ba8" })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#313244" })
	vim.api.nvim_set_hl(0, "Error", { fg = "#ce3d54", bold = true })
	vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#f9e2af", bold = true })
	vim.api.nvim_set_hl(0, "Hint", { fg = "#89dceb" })
	vim.api.nvim_set_hl(0, "Info", { fg = "#94e2d5" })
end

function M.setup()
	apply_highlights()

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = apply_highlights,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = apply_highlights,
	})
end

return M

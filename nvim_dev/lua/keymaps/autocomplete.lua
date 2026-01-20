-- opening help in vsplit
--
local group = vim.api.nvim_create_augroup("HelpVertical", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = {
		"help",
		"man",
		"h",
		"qf", -- Quickfix & Location List
		"checkhealth", -- Raporty diagnostyczne
		"query", -- Treesitter Playground / Inspect
		"lspinfo", -- Konfiguracja LSP
		"startuptime", -- Profilowanie (plugin dstein64)
		"gitsigns.blame", -- Blame w osobnym oknie
	},
	callback = function()
		-- Wymuś otwarcie w nowym pionowym oknie po prawej stronie
		vim.cmd("wincmd L")
		-- Opcjonalnie: ustaw szerokość na 80 kolumn
		vim.api.nvim_win_set_width(0, 80)
	end,
})<F5>

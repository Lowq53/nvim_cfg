-- Stwórz plik: lua/plugins/colorscheme.lua

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true, -- <-- ZMIEŃ NA true
			terminal_colors = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		})
		vim.cmd [[colorscheme tokyonight]]
	end,
} -- Potem:
-- :Lazy sync
-- Restart nvim

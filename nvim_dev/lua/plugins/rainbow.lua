-- Stwórz nowy plik: lua/plugins/rainbow.lua

return {
	-- NAJLEPSZY PLUGIN 2024 - rainbow-delimiters.nvim (następca nvim-ts-rainbow2)
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy", -- Ładuje się leniwie
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"], -- Domyślna strategia
					-- vim = rainbow_delimiters.strategy["local"], -- Per-buffer dla VIM
				},
				query = {
					[""] = "rainbow-delimiters", -- Domyślne query
					lua = "rainbow-blocks", -- Dla Lua użyj bloków (begin/end)
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}

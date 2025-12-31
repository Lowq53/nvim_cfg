-- ~/.config/nvim/lua/plugins/oil.lua
return {
	--   To najpotężniejsze narzędzie w Twoim stacku, jeśli umiesz je skonfigurować pod swoje palce.
	--
	-- W Oil.nvim domyślne mapowania są zaszyte wewnątrz funkcji setup. Jeśli chcesz dodać q do zamykania lub kopiowanie ścieżki, musisz to zrobić wewnątrz klucza keymaps.
	--
	-- Twój zoptymalizowany config Oil.nvim
	-- Oto kompletny, poprawiony kod z obsługą kopiowania ścieżki, zamykaniem pod q oraz integracją z Twoim systemem.
	--
	-- Lua
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			-- Wizualne aspekty
			columns = { "icon" },
			view_options = {
				show_hidden = true, -- Seniorzy zawsze patrzą na pliki ukryte (.git, .env)
			},
			-- KONFIGURACJA KLUCZY WEWNĄTRZ OIL
			keymaps = {
				["g?"] = "actions.show_help", -- Sprawdza listę wszystkich mapowań
				["<CR>"] = "actions.select",
				["<C-h>"] = "actions.select_split",
				["<C-v>"] = "actions.select_vsplit",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",

				-- TWOJE NIESTANDARDOWE MAPOWANIA:
				["q"] = "actions.close", -- Zamykanie pod 'q'
				["<ESC>"] = "actions.close", -- Zamykanie pod ESC

				-- KOPIOWANIE ŚCIEŻKI (\pa)
				-- Tworzymy własną funkcję w Lua dla Oil
				["\\pa"] = {
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						if entry then
							local dir = oil.get_current_dir()
							local full_path = dir .. entry.name
							vim.fn.setreg("+", full_path) -- Kopiuje do systemowego schowka
							print("Copied: " .. full_path)
						end
					end,
					desc = "Copy full path to clipboard",
				},
			},
		})
	end,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
}


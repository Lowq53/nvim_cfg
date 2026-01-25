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
			delete_to_trash = true,
      -- bes tego nie bedie defaultoych keymapow 
      use_default_keymaps = true,
			-- Wizualne aspekty
			columns = { "icon" },
			view_options = {
				-- Pokaż ukryte pliki (kropka na początku)
				show_hidden = true,
				-- Funkcja sprawdzająca, czy plik ma być ukryty
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".") and name ~= ".."
				end,
				-- Funkcja sprawdzająca, czy plik jest ignorowany przez git
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			float = {
				padding = 2,
				max_width = 100,
				max_height = 20,
				border = "rounded", -- Seniorzy kochają estetykę 'rounded'
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
				["gh"] = "actions.toggle_hidden", -- Toggle ukrytych plików
				--["y"] = "actions.copy_to_clipboard",
				-- ["d"] = "actions.delete",
				-- ["r"] = "actions.rename",
				-- ["a"] = "actions.create",
				-- ["."] = "actions.set_current_filter",
				--
				-- TWOJE NIESTANDARDOWE MAPOWANIA:
				["q"] = "actions.close", -- Zamykanie pod 'q'
				["<ESC>"] = "actions.close", -- Zamykanie pod ESC
				["<M-->"] = "actions.cd", -- Mapowanie Alt + - dla zmiany PWD

				-- KOPIOWANIE ŚCIEŻKI (\pa)
				-- Tworzymy własną funkcję w Lua dla Oil
				["yp"] = {
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
				-- SENIOR WORKFLOW: Szybkie porównanie pliku pod kursorem z bieżącym buforem
				["<leader>dp"] = {
					desc = "Diff: Compare file under cursor with last buffer",
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						if not entry then
							return
						end

						-- Pobieramy pełną ścieżkę do pliku pod kursorem
						local dir = oil.get_current_dir()
						local fileName = entry.name
						local fullPath = dir .. fileName

						-- Zamykamy Oil, otwieramy plik w splicie i odpalamy diff
						oil.close()
						vim.cmd("vertical diffsplit " .. vim.fn.fnameescape(fullPath))
					end,
				},
			},
		})
	end,
	keys = {
		-- it need to be here to open oil from any buffor
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		-- Mapowanie otwierające Oil w oknie pływającym
		vim.keymap.set("n", "<leader>fo", function()
			require("oil").toggle_float()
		end, { desc = "Oil: Toggle Floating" }),
	},
}

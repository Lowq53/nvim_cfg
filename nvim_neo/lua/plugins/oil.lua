return {
	-- Oil.nvim
	--https://github.com/stevearc/oil.nvim
	{
		"stevearc/oil.nvim",
		lazy = false,
		config = function()
			require("oil").setup({
				dependencies = { { "echasnovski/mini.icons", opts = {} } },
				view_options = {
					show_hidden = true,
					default_file_explorer = true,
					delete_to_trash = true, -- poprawka: trash nie trast
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
	},
	-- nvim-tree -- file manager
	-- https://github.com/nvim-tree/nvim-tree.lua
	{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	-- UndoTree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>pu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
		},
		init = function()
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_TreeVertSplit = 1
		end,
		keys = {
			-- it need to be here to open oil from any buffor
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
	},
}

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- 🔧 Podstawowa konfiguracja nvim-tree
		require("nvim-tree").setup({
			sort_by = "name",
			view = {
				width = 35,
				side = "left",
				number = false,
				relativenumber = false,
			},
			renderer = {
				highlight_git = true,
				group_empty = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			git = {
				enable = true,
				ignore = false,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filters = {
				dotfiles = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
		})

		-- 🎹 Skróty klawiszowe
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true, desc = "[NvimTree]" }

		-- Przełączanie drzewa
		keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
		-- Otwórz drzewo i pokaż bieżący plik
		keymap("n", "<leader>o", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Focus File in Tree" })
		-- Odśwież drzewo
		keymap("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh File Explorer" })
	end,
}

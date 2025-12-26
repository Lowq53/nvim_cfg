return {
	{
		"Pocco81/auto-save.nvim",
		event = "BufReadPost", -- ładuje się po otwarciu bufora
		config = function()
			require("auto-save").setup({
				enabled = false, -- włączony
				execution_message = false, -- nie pokazuj komunikatu
				events = { "InsertLeave" }, -- lista eventów, przy których zapisuje
				conditions = {
					exists = true,
					filetype_is_not = {},
					-- file_path_is_not = { "lua/plugins/*", "lua/config/*" },:w -- wykluczone
				},
				write_all_buffers = false, -- zapisuje tylko aktualny buffer
				trigger_events = { -- możesz dodać dodatkowe eventy
					--"InsertLeave", -- wychodzisz z trybu insert
					"BufLeave", -- zmiana bufora / panela
					"FocusLost", -- kiedy tracisz fokus Neovim
				},
				timeout = 180000, -- ms, np. 3 min przy InsertLeave
			})
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
	},
	"kkoomen/vim-doge",
}

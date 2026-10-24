return {
	-- W Twojej liście pluginów (np. lazy.nvim)
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "sa",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
					suffix_last = "l",
					suffix_next = "n",
				},
			})
		end,
	},
}

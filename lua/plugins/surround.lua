return {
	-- W Twojej liście pluginów (np. lazy.nvim)
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "sa", -- Add: dodaj otoczenie
					delete = "sd", -- Delete: usuń
					replace = "sr", -- Replace: zamień
				},
			})
		end,
	},
}

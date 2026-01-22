return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
		notification = {
			override_vim_notify = true,
		},
	},
}

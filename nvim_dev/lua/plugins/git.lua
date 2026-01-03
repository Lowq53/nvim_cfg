return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+M" },
				change = { text = "~M" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
		},
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
		keys = {
			{ "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit Status" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
		},
	},
}

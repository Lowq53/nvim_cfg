-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\plugins\session_manager_dev.lua
return {
	{
		"Lowq53/nvim-session-manager",
		enabled = false, -- 🔴 WYŁĄCZONY
	},
	{
		dir = "C://dev//nvimdev//nvim-session-manager",
		name = "local-session-manager",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "Ss", "Sr", "Sl" },

		config = function()
			require("session_manager").setup({
				base_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/sessions"),
			})
		end,

		keys = {
			{ "<leader>sm", "<cmd>Ss main<CR>", desc = "Save Main Session" },
			{ "<leader>rm", "<cmd>Sr main<CR>", desc = "Restore Main Session" },
			{ "<leader>sl", "<cmd>Sl<CR>", desc = "List Sessions" },
		},
	},
}

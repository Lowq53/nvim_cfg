return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- 1. First load your custom statusline config
			local statusline_cfg = require("styles.evil_lualine")

			-- 2. Initialize lualine with your config
			require("lualine").setup(statusline_cfg)

			-- 3. Cmdline visibility management
			vim.opt.cmdheight = 0 -- Hide by default

			-- Show during command input
			vim.api.nvim_create_autocmd("CmdlineEnter", {
				callback = function()
					vim.opt.cmdheight = 1
					-- Switch to minimal lualine
					require("lualine").setup({
						sections = {
							lualine_a = { "mode" },
							lualine_b = {},
							lualine_c = {},
							-- Empty other sections
						},
					})
				end,
			})

			-- Restore when done
			vim.api.nvim_create_autocmd("CmdlineLeave", {
				callback = function()
					vim.opt.cmdheight = 0
					-- Restore original lualine config
					require("lualine").setup(statusline_cfg)
				end,
			})
		end,
		event = "VeryLazy",
	},
}

return {
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	ft = "markdown",
	-- 	build = "cd app && yarn install",
	-- 	config = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- },

	{
		"ellisonleao/glow.nvim",
		ft = { "markdown" },
		config = true,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
	},
	"kkoomen/vim-doge",
}

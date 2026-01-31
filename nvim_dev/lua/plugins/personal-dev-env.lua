return {
	-- 1. MASON - instalator LSP/formatters/linters
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "VeryLazy", -- NEW: load after UI to keep startup snappy
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- 2. MASON-LSPCONFIG - mostek między Mason a LSP
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- NEW: load only when a file is opened
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"pyright", -- Python
				"ts_ls", -- TypeScript/JavaScript
				"html", -- HTML
				"cssls", -- CSS

				"rust_analyzer",
			},
			automatic_enable = true, -- AUTO włącza zainstalowane LSP (v2.0)
		},
	},

	{ "neovim/nvim-lspconfig", lazy = true },

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"prettier",
				"black",
			},
		},
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- 6. COMMENT: Ładuj przy pierwszej próbie użycia lub VeryLazy
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy", -- NEW: non-critical UI plugin
		config = true, -- OLD: required "require('Comment').setup()" | NEW: automatic
	},
}

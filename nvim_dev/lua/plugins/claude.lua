return {
	{
		"yetone/avante.nvim",
		enabled = true,
		event = "VeryLazy",
		cmd = { "AvanteAsk", "AvanteEdit", "AvanteToggle" },
		lazy = false,
		version = false,
		opts = {
			provider = "gemini",
			providers = {

				-- ✅ GEMINI (działa natywnie w avante)
				gemini = {
					model = "gemini-1.5-flash",
					api_key_name = "MAIN_GEMINI_API_KEY",
					extra_request_body = {
						max_tokens = 4096,
						temperature = 0,
					},
				},

				-- ✅ OPENROUTER (MUSI dziedziczyć z openai)
				openrouter = {
					__inherited_from = "openai",

					endpoint = "https://openrouter.ai/api/v1",
					model = "deepseek/deepseek-r1:free",
					api_key_name = "OPENROUTER_API_KEY",
				},

				-- ✅ CLAUDE (MUSI dziedziczyć z anthropic)
				claude = {
					__inherited_from = "anthropic",

					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					api_key_name = "ANTHROPIC_API_KEY",

					extra_request_body = {
						max_tokens = 4096,
						temperature = 0,
					},
				},
			},
			auto_suggestions_provider = "gemini",
			behaviour = {
				auto_suggestions = false,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},
			mappings = {
				ask = ",aa",
				edit = ",ae",
				refresh = ",ar",
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				sidebar = {
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},
			hints = { enabled = true },
			windows = {
				position = "right",
				wrap = true,
				width = 30,
				sidebar_header = {
					align = "center",
					rounded = true,
				},
			},
			highlights = {
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}

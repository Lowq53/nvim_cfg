return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			provider = "openrouter", -- DOMYŚLNY (darmowy)

			-- Provider 1: OpenRouter (darmowy)
			openrouter = {
				endpoint = "https://openrouter.ai/api/v1",
				model = "deepseek/deepseek-r1:free",
				api_key_name = "OPENROUTER_API_KEY",
			},

			-- Provider 2: Claude (płatny)
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				temperature = 0,
				max_tokens = 4096,
			},

			auto_suggestions_provider = "openrouter", -- ZMIEŃ na openrouter
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

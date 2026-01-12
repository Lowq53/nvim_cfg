return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	-- build = "make tiktoken", -- Only on MacOS or linux
	event = "VeryLazy",
	opts = function()
		local prompts = require("CopilotChat.prompts")

		return {
			-- ===== CORE =====
			debug = false,
			model = "gpt-4o",
			temperature = 0.1,
			system_prompt = prompts.COPILOT_INSTRUCTIONS,

			-- ===== UI =====
			question_header = "## User",
			answer_header = "## Copilot",
			error_header = "## Error",
			separator = "───",

			show_help = true,
			show_folds = true,
			auto_follow_cursor = true,
			auto_insert_mode = false,

			-- ===== WINDOW =====
			window = {
				layout = "float", -- float | vertical | horizontal
				border = "rounded",
				title = "Copilot Chat",
				width = 0.6,
				height = 0.6,
			},

			-- ===== KEYMAPS (wewnątrz chatu) =====
			mappings = {
				close = { normal = "q", insert = "<C-c>" },
				close = { normal = "esc", insert = "<C-c>" },
				reset = { normal = "<C-l>", insert = "<C-l>" },
				submit_prompt = { normal = "<CR>", insert = "<C-s>" },
				accept_diff = { normal = "<C-y>", insert = "<C-y>" },
				yank_diff = { normal = "gy", register = '"' },
				show_diff = { normal = "gd" },
				show_system_prompt = { normal = "gp" },
				show_user_selection = { normal = "gs" },
				complete = {
					insert = "<Tab>",
					detail = "Use @<Tab> or /<Tab> to complete",
				},
			},
		}
	end,
}
-- copilot start
-- Lazy load copilot.nvim
--
--
--:CopilotChat <input>?        — otwiera chat z opcjonalnym tekstem wejściowym
-- :CopilotChatOpen            — otwiera chat
-- :CopilotChatClose           — zamyka chat
-- :CopilotChatToggle          — przełącza okno
-- :CopilotChatStop            — zatrzymuje aktualną odpowiedź AI
-- :CopilotChatReset           — resetuje sesję
-- :CopilotChatSave <name>?    — zapisuje historię chatu do pliku
-- :CopilotChatLoad <name>?    — ładuje historię chatu z pliku
-- :CopilotChatDebugInfo       — debug info (logi, status)
-- :CopilotChatModels          — pokazuje i pozwala wybrać model
-- :CopilotChatModel           — pokazuje aktualnie wybrany model

-- :CopilotChatExplain
-- :CopilotChatReview
-- :CopilotChatFix
-- :CopilotChatOptimize
-- :CopilotChatDocs
-- :CopilotChatTests
-- :CopilotChatFixDiagnostic
-- :CopilotChatCommit
-- :CopilotChatCommitStaged

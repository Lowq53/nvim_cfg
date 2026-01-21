-- help copilot
-- help copilot-maps
-- help copilot-commands
-- help copilot-chat-commands
-- help CopilotChat

---@module 'copilotchat'
---@description Konfiguracja CopilotChat dla Neovim
---Integruje GitHub Copilot z możliwością czatu, code review, fix, explain i innych funkcji AI
---@dependencies zbirenbaum/copilot.lua, nvim-lua/plenary.nvim

return {
	"CopilotC-nvim/copilotchat.nvim",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	event = "VeryLazy",

	config = function()
		-- Setup copilot.lua
		require("copilot").setup({
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = false,
			},
		})

		-- Setup CopilotChat
		local prompts = require("CopilotChat.prompts")
		require("CopilotChat").setup({
			debug = false,
			model = "gpt-4o",
			temperature = 0.1,
			system_prompt = prompts.copilot_instructions,
			question_header = "## user",
			answer_header = "## copilot",
			error_header = "## error",
			separator = "───",
			show_help = true,
			show_folds = true,
			auto_follow_cursor = true,
			auto_insert_mode = false,
			window = {
				layout = "float",
				border = "rounded",
				title = "copilot chat",
				width = 0.6,
				height = 0.6,
			},
			mappings = {
				close = { normal = "<esc>", "q", insert = "<c-c>" },
				reset = { normal = "<c-r>", "<c-x>", insert = "<c-r>" },
				dismiss_suggestion = { normal = "<c-c>", "<c-d>", insert = "<c-c>" },
				submit_prompt = { normal = "<c-e>", insert = "<c-s>" },
				accept_diff = { normal = "<c-y>", insert = "<c-y>" },
				yank_diff = { normal = "gy", register = '"' },
				show_diff = { normal = "gd" },
				show_system_prompt = { normal = "gp" },
				show_user_selection = { normal = "gs" },
				complete = {
					insert = "<tab>",
					detail = "use @<tab> or /<tab> to complete",
				},
			},
		})

		-- Auto-close Copilot limit popup
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			callback = function()
				vim.defer_fn(function()
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.bo[buf].filetype
						local bt = vim.bo[buf].buftype

						if ft == "lazy" or ft == "log" or bt == "quickfix" or bt == "help" then
							goto continue
						end

						local ok, lines = pcall(vim.api.nvim_buf_get_lines, buf, 0, -1, false)
						if ok then
							for _, line in ipairs(lines) do
								if
									line:match("[Ll]imit") and (line:match("[Uu]pgrade") or line:match("[Dd]ismiss"))
								then
									pcall(vim.api.nvim_win_close, win, true)
									return
								end
							end
						end

						::continue::
					end
				end, 300)
			end,
		})
	end,

	init = function()
		local banned_messages = {
			"upgrade",
			"plan",
			"monthly",
			"limit",
			"reached",
			"subscription",
		}
		vim.notify = (function(orig)
			return function(msg, level, opts)
				if type(msg) == "string" then
					local lower = msg:lower()
					for _, word in ipairs(banned_messages) do
						if lower:find(word, 1, true) then
							return
						end
					end
				end
				return orig(msg, level, opts)
			end
		end)(vim.notify)
	end,

	---@function keys
	---@description Definiuje wszystkie keybindings dla CopilotChat
	---@return table Array z konfiguracją klawiszy dla lazy.nvim
	keys = function()
		---@function toggle_feature
		---@description Przełącza stan custom feature (ON/OFF) z notyfikacją
		---@local
		local feature_enabled = false
		local toggle_feature = function()
			feature_enabled = not feature_enabled
			vim.notify("Feature: " .. (feature_enabled and "ON" or "OFF"))
		end

		return {
			-- ▰▰▰▰▰▰▰▰▰▰▰ PODSTAWOWE TOGGLE ▰▰▰▰▰▰▰▰▰▰▰
			{ "<c-p>", "<cmd>CopilotChatToggle<cr>", desc = "copilot: toggle chat" },
			{ "<leader>ct", toggle_feature, desc = "copilot: toggle feature" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ VISUAL MODE - DZIAŁANIA NA ZAZNACZONYM KODZIE ▰▰▰▰▰▰▰▰▰▰▰
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "copilot: explain" },
			{ "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "copilot: review" },
			{ "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "copilot: fix" },
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "copilot: optimize" },
			{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "copilot: docs" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ NORMAL MODE - PODSTAWOWE OPERACJE ▰▰▰▰▰▰▰▰▰▰▰
			{ "<leader>cc", "<cmd>CopilotChat<cr>", desc = "copilot: open chat" },
			{ "<leader>cs", "<cmd>CopilotChatStop<cr>", desc = "copilot: stop" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ ZARZĄDZANIE MODELAMI I PROMPTAMI ▰▰▰▰▰▰▰▰▰▰▰
			{ "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "copilot: select model" },
			{ "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "copilot: prompts" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ HISTORIA CZATU ▰▰▰▰▰▰▰▰▰▰▰
			{ "<leader>cl", "<cmd>CopilotChatLoad<cr>", desc = "copilot: load chat" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ GIT OPERACJE ▰▰▰▰▰▰▰▰▰▰▰
			{ "<leader>cg", "<cmd>CopilotChatCommit<cr>", desc = "copilot: generate commit" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ TESTY ▰▰▰▰▰▰▰▰▰▰▰
			{
				"<leader>cT",
				function()
					vim.notify(
						"You've reached your monthly code completion limit. Upgrade your plan to Copilot Pro",
						vim.log.levels.WARN,
						{ title = "GitHub Copilot" }
					)
				end,
				desc = "copilot: TEST limit (should be blocked)",
			},
			{
				"<leader>cN",
				function()
					vim.notify("Hello World - Normal notification TEST", vim.log.levels.INFO)
				end,
				desc = "copilot: TEST normal notification",
			},
		}
	end,
}

-- ═══════════════════════════════════════════════════════════════════════════
-- DOSTĘPNE KOMENDY COPILOTCHAT
-- ═══════════════════════════════════════════════════════════════════════════
-- :CopilotChat <input>?        — otwiera chat z opcjonalnym tekstem wejściowym
-- :CopilotChatOpen             — otwiera chat
-- :CopilotChatClose            — zamyka chat
-- :CopilotChatToggle           — przełącza okno
-- :CopilotChatStop             — zatrzymuje aktualną odpowiedź AI
-- :CopilotChatReset            — resetuje sesję
-- :CopilotChatSave <name>?     — zapisuje historię chatu do pliku
-- :CopilotChatLoad <name>?     — ładuje historię chatu z pliku
-- :CopilotChatDebugInfo        — debug info (logi, status)
-- :CopilotChatModels           — pokazuje i pozwala wybrać model
-- :CopilotChatModel            — pokazuje aktualnie wybrany model
--
-- ═══════════════════════════════════════════════════════════════════════════
-- PREDEFINIOWANE PROMPTY
-- ═══════════════════════════════════════════════════════════════════════════
-- :CopilotChatExplain          — wyjaśnia zaznaczony kod
-- :CopilotChatReview           — code review
-- :CopilotChatFix              — naprawia błędy
-- :CopilotChatOptimize         — optymalizuje kod
-- :CopilotChatDocs             — generuje dokumentację
-- :CopilotChatTests            — generuje testy
-- :CopilotChatFixDiagnostic    — naprawia diagnostyczne błędy
-- :CopilotChatCommit           — generuje commit message
-- :CopilotChatCommitStaged     — generuje commit message dla staged changes

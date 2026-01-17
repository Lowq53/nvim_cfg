--2. Funkcja toggle
local feature_enabled = false
local function toggle_feature()
	feature_enabled = not feature_enabled
	if feature_enabled then
		print("Feature Enabled")
		-- tutaj dodajesz kod włączający funkcję Copilot lub własną logikę
	else
		print("Feature Disabled")
		-- tutaj kod wyłączający funkcję
	end
end

-- Define a function to handle the keymap behavior
local function handle_copilot_keymap()
	local copilot = require("copilot") -- Ensure you have the correct module name
	if copilot.is_answering() then
		copilot.stop_answering() -- Stop the current response
	else
		copilot.toggle_chat() -- Toggle the chat window
	end
end

-- help copilot
-- help copilot-maps
-- help copilot-commands
-- help copilot-chat-commands
-- help CopilotChat

return {
	"CopilotC-nvim/copilotchat.nvim",
	dependencies = {
		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	-- build = "make tiktoken", -- only on macos or linux
	event = "VeryLazy",

	-- keys na zewnątrz opts (lazy.nvim format)
	-- keys - globalne lazy -loadin, poza otps
	keys = {

		-- toggle feature
		-- 	{
		-- 		key = "<space>c",
		-- 		mode = "n",
		-- 		callback = toggle_feature, -- <- prawidłowa funkcja lua
		-- 		desc = "toggle feature",
		-- 	},
		-- 	"<c-p>",
		-- 	"<cmd>CopilotChattoggle<cr>",
		-- 	desc = "copilot: toggle chat",
		-- },
		{ "<c-p>", "<cmd>CopilotChattoggle<cr>", desc = "copilot: toggle chat" },

		{ "<leader>ce", "<cmd>CopilotChatexplain<cr>", mode = "v", desc = "copilot: explain" },
		{ "<leader>cr", "<cmd>CopilotChatreview<cr>", mode = "v", desc = "copilot: review" },
		{ "<leader>cf", "<cmd>CopilotChatfix<cr>", mode = "v", desc = "copilot: fix" },
		{ "<leader>ct", toggle_feature, desc = "copilot: toggle feature" },
		-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

		-- toggle funkcje główne
		{ "<c-p>", "<cmd>CopilotChattoggle<cr>", desc = "copilot: toggle chat" },
		{ "<leader>ct", toggle_feature, desc = "copilot: toggle feature" },

		-- visual mode - działania na zaznaczonym kodzie
		{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "copilot: explain" },
		{ "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "copilot: review" },
		{ "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "copilot: fix" },
		{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "copilot: optimize" },
		{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "copilot: docs" },
		{ "<leader>ct", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "copilot: tests" },

		-- normal mode - podstawowe operacje
		{ "<leader>cc", "<cmd>CopilotChat<cr>", desc = "copilot: open chat" },
		{ "<leader>cc", "<cmd>CopilotChatClose<cr>", desc = "copilot: close chat" },
		{ "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "copilot: reset chat" },
		{ "<leader>cs", "<cmd>CopilotChatStop<cr>", desc = "copilot: stop" },

		-- zarządzanie modelami i promptami
		{ "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "copilot: select model" },
		{ "<leader>cm", "<cmd>CopilotChatModel<cr>", desc = "copilot: current model" },
		{ "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "copilot: prompts" },

		-- historia czatu
		{ "<leader>cs", "<cmd>CopilotChatSave<cr>", desc = "copilot: save chat" },
		{ "<leader>cl", "<cmd>CopilotChatLoad<cr>", desc = "copilot: load chat" },

		-- git operacje
		{ "<leader>cg", "<cmd>CopilotChatCommit<cr>", desc = "copilot: generate commit" },
		-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

		-- dodatkowe mapowania klawiszy można dodać tutaj
		-- -- ===== zakomentowane - przykłady do dodania =====

		-- quick chat - szybkie zapytanie
		-- {
		-- 	"<leader>cq",
		-- 	function()
		-- 		local input = vim.fn.input("quick chat: ")
		-- 		if input ~= "" then
		-- 			require("CopilotChat").ask(input, { selection = require("copilotchat.select").buffer })
		-- 		end
		-- 	end,
		-- 	desc = "copilot: quick chat",
		-- },

		-- quick chat z visual selection
		-- {
		-- 	"<leader>cq",
		-- 	function()
		-- 		local input = vim.fn.input("quick chat: ")
		-- 		if input ~= "" then
		-- 			require("CopilotChat").ask(input)
		-- 		end
		-- 	end,
		-- 	mode = "v",
		-- 	desc = "copilot: quick chat (visual)",
		-- },

		-- debug help
		-- {
		-- 	"<leader>cb",
		-- 	"<cmd>CopilotChat #buffer debug this code and explain potential issues<cr>",
		-- 	desc = "copilot: debug code",
		-- },

		-- custom prompts - dodaj swoje
		-- { "<leader>ce", "<cmd>CopilotChatexplaindeep<cr>", desc = "copilot: deep explain" },
		-- { "<leader>cb", "<cmd>CopilotChatbestpractices<cr>", desc = "copilot: best practices" },
		-- { "<leader>cp", "<cmd>CopilotChatperformance<cr>", desc = "copilot: performance tips" },
		-- { "<leader>cd", "<cmd>CopilotChatdebug<cr>", desc = "copilot: debug help" },

		-- inline actions
		-- {
		-- 	"<leader>ci",
		-- 	function()
		-- 		require("CopilotChat").open({ window = { layout = "float", relative = "cursor" } })
		-- 	end,
		-- 	desc = "copilot: inline chat",
		-- },

		-- toggle z konfiguracją okna
		-- {
		-- 	"<leader>cv",
		-- 	function()
		-- 		require("CopilotChat").toggle({ window = { layout = "vertical" } })
		-- 	end,
		-- 	desc = "copilot: vertical chat",
		-- },
		-- {
		-- 	"<leader>ch",
		-- 	function()
		-- 		require("CopilotChat").toggle({ window = { layout = "horizontal" } })
		-- 	end,
		-- 	desc = "copilot: horizontal chat",
		-- },

		-- zapytanie o bieżący bufor
		-- {
		-- 	"<leader>cw",
		-- 	"<cmd>CopilotChat #buffer what does this code do?<cr>",
		-- 	desc = "copilot: what does code do",
		-- },

		-- zapytanie o git diff
		-- {
		-- 	"<leader>cg",
		-- 	"<cmd>CopilotChat #gitdiff:staged explain these changes<cr>",
		-- 	desc = "copilot: explain git diff",
		-- },

		-- focus na chat window
		-- {
		-- 	"<leader>cf",
		-- 	function()
		-- 		require("CopilotChat").focus()
		-- 	end,
		-- 	desc = "copilot: focus chat",
		--
	},
	opts = function()
		local prompts = require("CopilotChat.prompts")

		return {
			-- ===== core =====
			debug = false,
			model = "gpt-4o",
			temperature = 0.1,
			system_prompt = prompts.copilot_instructions,

			-- ===== ui =====
			question_header = "## user",
			answer_header = "## copilot",
			error_header = "## error",
			separator = "───",

			show_help = true,
			show_folds = true,
			auto_follow_cursor = true,
			auto_insert_mode = false,

			-- ===== window =====
			window = {
				layout = "float", -- float | vertical | horizontal
				border = "rounded",
				title = "copilot chat",
				width = 0.6,
				height = 0.6,
			},

			-- ===== keymaps (wewnątrz chatu) =====
			-- mappings w oknie chatu, w opts
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
				-- shortcut do toggla naszej funkcji
				toggle_feature = { normal = "<space>c" },
			},

			-- {
			-- 	".l",
			-- 	mode = "i",
			-- 	expr = true,
			-- 	function()
			-- 		return vim.fn["copilot#accept"]("")
			-- 	end,
			-- 	desc = "copilot: accept suggestion",
			-- },
			-- toggle chat window
			-- vim.api.nvim_set_keymap(
			-- 	"n",
			-- 	"<space>cc",
			-- 	":copilot chat toggle<cr>",
			-- 	{ noremap = true, silent = true },
			-- 	-- następna / poprzednia sugestia
			-- 	{ ".n", mode = "i", "<plug>(copilot-next)", desc = "copilot: next suggestion" }
			-- ),
			--

			-- {
			-- 	key = "<space>c",
			-- 	mode = "n",
			-- 	callback = toggle_feature, -- <- funkcja lua
			-- 	desc = "toggle feature",
			-- },

			--[[ { ".p", mode = "i", "<plug>(copilot-previous)", desc = "copilot: previous suggestion" }, ]]

			-- -- inne przydatne
			-- { ".d", mode = "i", "<plug>(copilot-dismiss)", desc = "copilot: dismiss suggestion" },
			-- { "<ctrl>l", mode = "i", "<plug>(copilot-accept-word)", desc = "copilot: accept word" },
			-- { "<ctrl>k", mode = "i", "<plug>(copilot-accept-line)", desc = "copilot: accept line" },
			--
			-- -- opcjonalnie – włącz/wyłącz (normal mode)
			--
			-- { ".s", mode = "n", ":copilot status<cr>", desc = "copilot: status" },
			-- { ".e", mode = "n", ":copilot enable<cr>" },
			-- { ".d", mode = "n", ":copilot disable<cr>" },
		}
	end,
}

-- copilot setup
-- copilot start
-- lazy load copilot.nvim
--
--
--:CopilotChat <input>?        — otwiera chat z opcjonalnym tekstem wejściowym
-- :CopilotChatopen            — otwiera chat
-- :CopilotChatclose           — zamyka chat
-- :CopilotChattoggle          — przełącza okno
-- :CopilotChatstop            — zatrzymuje aktualną odpowiedź ai
-- :CopilotChatreset           — resetuje sesję
-- :CopilotChatsave <name>?    — zapisuje historię chatu do pliku
-- :CopilotChatload <name>?    — ładuje historię chatu z pliku
-- :CopilotChatdebuginfo       — debug info (logi, status)
-- :CopilotChatmodels          — pokazuje i pozwala wybrać model
-- :CopilotChatmodel           — pokazuje aktualnie wybrany model

-- :CopilotChatexplain
-- :CopilotChatreview
-- :CopilotChatfix
-- :CopilotChatoptimize
-- :CopilotChatdocs
-- :CopilotChattests
-- :CopilotChatfixdiagnostic
-- :CopilotChatcommit
-- :CopilotChatCommitStaged

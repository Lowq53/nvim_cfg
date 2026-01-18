-- help copilot
-- help copilot-maps
-- help copilot-commands
-- help copilot-chat-commands
-- help CopilotChat

---@module 'copilotchat'
---@description Konfiguracja CopilotChat dla Neovim
---Integruje GitHub Copilot z możliwością czatu, code review, fix, explain i innych funkcji AI
---@dependencies github/copilot.vim, nvim-lua/plenary.nvim
return {
	"CopilotC-nvim/copilotchat.nvim",
	dependencies = {
		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	-- build = "make tiktoken", -- only on macos or linux
	event = "VeryLazy",
	--
	-- init = function()
	-- 	local banned = {
	-- 		"upgrade",
	-- 		"plan",
	-- 		"monthly",
	-- 		"limit",
	-- 		"reached",
	-- 		"trial",
	-- 		"pro",
	-- 		"subscription",
	-- 	}
	--
	-- 	-- Tylko notify - NIE zamykaj buforów
	-- 	vim.notify = (function(orig)
	-- 		return function(msg, level, opts)
	-- 			if type(msg) == "string" then
	-- 				local lower = msg:lower()
	-- 				for _, word in ipairs(banned) do
	-- 					if lower:find(word, 1, true) then
	-- 						return -- Zablokuj tylko notyfikację
	-- 					end
	-- 				end
	-- 			end
	--
	-- 			if opts and type(opts.title) == "string" then
	-- 				local lower = opts.title:lower()
	-- 				for _, word in ipairs(banned) do
	-- 					if lower:find(word, 1, true) then
	-- 						return
	-- 					end
	-- 				end
	-- 			end
	--
	-- 			return orig(msg, level, opts)
	-- 		end
	-- 	end)(vim.notify)
	-- end,

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

		---@function handle_smart_toggle
		---@description Inteligentne przełączanie okna czatu (API 0.11+)
		---W nowej wersji: stop() przerywa generowanie, toggle() przełącza okno
		---@unused Zakomentowane - przykład zaawansowanego użycia
		-- local handle_smart_toggle = function()
		-- 	local chat = require("CopilotChat")
		-- 	chat.toggle()
		-- end

		-- keys - globalne lazy-loading, poza opts
		return {
			-- ▰▰▰▰▰▰▰▰▰▰▰ PODSTAWOWE TOGGLE ▰▰▰▰▰▰▰▰▰▰▰
			---Toggle okna czatu - główny skrót
			{ "<c-p>", "<cmd>CopilotChatToggle<cr>", desc = "copilot: toggle chat" },

			---Toggle custom feature
			{ "<leader>ct", toggle_feature, desc = "copilot: toggle feature" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ VISUAL MODE - DZIAŁANIA NA ZAZNACZONYM KODZIE ▰▰▰▰▰▰▰▰▰▰▰
			---Wyjaśnia zaznaczony kod
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "copilot: explain" },

			---Code review zaznaczonego fragmentu
			{ "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "copilot: review" },

			---Naprawia błędy w zaznaczonym kodzie
			{ "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "copilot: fix" },

			---Optymalizuje zaznaczony kod
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "copilot: optimize" },

			---Generuje dokumentację dla zaznaczonego kodu
			{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "copilot: docs" },

			---Generuje testy dla zaznaczonego kodu
			-- { "<leader>ct", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "copilot: tests" }, -- duplikat z toggle_feature

			-- ▰▰▰▰▰▰▰▰▰▰▰ NORMAL MODE - PODSTAWOWE OPERACJE ▰▰▰▰▰▰▰▰▰▰▰
			---Otwiera okno czatu
			{ "<leader>cc", "<cmd>CopilotChat<cr>", desc = "copilot: open chat" },

			---Zamyka okno czatu
			-- { "<leader>cc", "<cmd>CopilotChatClose<cr>", desc = "copilot: close chat" }, -- duplikat klawisza z open

			---Resetuje sesję czatu
			-- { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "copilot: reset chat" }, -- duplikat z review (visual)

			---Zatrzymuje generowanie odpowiedzi
			{ "<leader>cs", "<cmd>CopilotChatStop<cr>", desc = "copilot: stop" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ ZARZĄDZANIE MODELAMI I PROMPTAMI ▰▰▰▰▰▰▰▰▰▰▰
			---Wybór modelu AI
			{ "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "copilot: select model" },

			---Pokazuje aktualny model
			-- { "<leader>cm", "<cmd>CopilotChatModel<cr>", desc = "copilot: current model" }, -- duplikat z select model

			---Lista dostępnych promptów
			{ "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "copilot: prompts" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ HISTORIA CZATU ▰▰▰▰▰▰▰▰▰▰▰
			---Zapisuje historię czatu do pliku
			-- { "<leader>cs", "<cmd>CopilotChatSave<cr>", desc = "copilot: save chat" }, -- duplikat z stop

			---Ładuje historię czatu z pliku
			{ "<leader>cl", "<cmd>CopilotChatLoad<cr>", desc = "copilot: load chat" },

			-- ▰▰▰▰▰▰▰▰▰▰▰ GIT OPERACJE ▰▰▰▰▰▰▰▰▰▰▰
			---Generuje commit message
			{ "<leader>cg", "<cmd>CopilotChatCommit<cr>", desc = "copilot: generate commit" },

			-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
			-- Na końcu przed zamknięciem return { }
			-- TEST: sprawdź czy filtr działa
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

			---TEST: Normalna notyfikacja (powinna się POKAZAĆ)
			{
				"<leader>cN",
				function()
					vim.notify("Hello World - Normal notification TEST", vim.log.levels.INFO)
				end,
				desc = "copilot: TEST normal notification",
			},

			-- ===== ZAKOMENTOWANE - PRZYKŁADY DO DODANIA =====

			-- ---Quick chat - szybkie zapytanie bez otwierania okna
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

			-- ---Quick chat z visual selection
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

			-- ---Debug help - analizuje kod i wyjaśnia potencjalne problemy
			-- {
			-- 	"<leader>cb",
			-- 	"<cmd>CopilotChat #buffer debug this code and explain potential issues<cr>",
			-- 	desc = "copilot: debug code",
			-- },

			-- ===== CUSTOM PROMPTS - DODAJ SWOJE =====
			-- { "<leader>ce", "<cmd>CopilotChatexplaindeep<cr>", desc = "copilot: deep explain" },
			-- { "<leader>cb", "<cmd>CopilotChatbestpractices<cr>", desc = "copilot: best practices" },
			-- { "<leader>cp", "<cmd>CopilotChatperformance<cr>", desc = "copilot: performance tips" },
			-- { "<leader>cd", "<cmd>CopilotChatdebug<cr>", desc = "copilot: debug help" },

			-- ===== INLINE ACTIONS =====
			-- ---Inline chat - okno przy kursorze
			-- {
			-- 	"<leader>ci",
			-- 	function()
			-- 		require("CopilotChat").open({ window = { layout = "float", relative = "cursor" } })
			-- 	end,
			-- 	desc = "copilot: inline chat",
			-- },

			-- ===== TOGGLE Z KONFIGURACJĄ OKNA =====
			-- ---Toggle vertical layout
			-- {
			-- 	"<leader>cv",
			-- 	function()
			-- 		require("CopilotChat").toggle({ window = { layout = "vertical" } })
			-- 	end,
			-- 	desc = "copilot: vertical chat",
			-- },
			-- ---Toggle horizontal layout
			-- {
			-- 	"<leader>ch",
			-- 	function()
			-- 		require("CopilotChat").toggle({ window = { layout = "horizontal" } })
			-- 	end,
			-- 	desc = "copilot: horizontal chat",
			-- },

			-- ===== ZAPYTANIA O BIEŻĄCY BUFOR =====
			-- ---Co robi ten kod?
			-- {
			-- 	"<leader>cw",
			-- 	"<cmd>CopilotChat #buffer what does this code do?<cr>",
			-- 	desc = "copilot: what does code do",
			-- },

			-- ===== ZAPYTANIE O GIT DIFF =====
			-- ---Wyjaśnia zmiany w git diff
			-- {
			-- 	"<leader>cg",
			-- 	"<cmd>CopilotChat #gitdiff:staged explain these changes<cr>",
			-- 	desc = "copilot: explain git diff",
			-- },

			-- ===== FOCUS NA CHAT WINDOW =====
			-- ---Przenosi focus na okno czatu
			-- {
			-- 	"<leader>cf",
			-- 	function()
			-- 		require("CopilotChat").focus()
			-- 	end,
			-- 	desc = "copilot: focus chat",
			-- },
		}
	end,

	---@function opts
	---@description Główna konfiguracja CopilotChat
	---@return table Konfiguracja pluginu
	opts = function()
		local prompts = require("CopilotChat.prompts")

		return {
			-- ===== CORE =====
			---Tryb debugowania
			debug = false,

			---Model AI do użycia
			model = "gpt-4o",

			---Temperatura odpowiedzi (0-1, niższa = bardziej deterministyczna)
			temperature = 0.1,

			---System prompt
			system_prompt = prompts.copilot_instructions,

			-- ===== UI =====
			---Nagłówek pytania użytkownika
			question_header = "## user",

			---Nagłówek odpowiedzi Copilot
			answer_header = "## copilot",

			---Nagłówek błędu
			error_header = "## error",

			---Separator między wiadomościami
			separator = "───",

			---Pokazuj help
			show_help = true,

			---Pokazuj foldy
			show_folds = true,

			---Auto follow kursor
			auto_follow_cursor = true,

			---Auto wejście w tryb insert
			auto_insert_mode = false,

			-- ===== WINDOW =====
			---Konfiguracja okna czatu
			window = {
				---Layout: float | vertical | horizontal
				layout = "float",

				---Styl ramki
				border = "rounded",

				---Tytuł okna
				title = "copilot chat",

				---Szerokość (0-1 jako procent lub liczba pikseli)
				width = 0.6,

				---Wysokość (0-1 jako procent lub liczba pikseli)
				height = 0.6,
			},

			-- ===== KEYMAPS (WEWNĄTRZ OKNA CHATU) =====
			---Mapowania klawiszy wewnątrz okna chatu
			mappings = {
				---Zamknij okno czatu
				close = { normal = "<esc>", "q", insert = "<c-c>" },

				---Resetuj sesję czatu
				reset = { normal = "<c-r>", "<c-x>", insert = "<c-r>" },

				---Odrzuć sugestię
				dismiss_suggestion = { normal = "<c-c>", "<c-d>", insert = "<c-c>" },

				---Wyślij prompt
				submit_prompt = { normal = "<c-e>", insert = "<c-s>" },

				---Zaakceptuj diff
				accept_diff = { normal = "<c-y>", insert = "<c-y>" },

				---Skopiuj diff
				yank_diff = { normal = "gy", register = '"' },

				---Pokaż diff
				show_diff = { normal = "gd" },

				---Pokaż system prompt
				show_system_prompt = { normal = "gp" },

				---Pokaż user selection
				show_user_selection = { normal = "gs" },

				---Autocomplete
				complete = {
					insert = "<tab>",
					detail = "use @<tab> or /<tab> to complete",
				},
			},

			-- ===== ZAKOMENTOWANE PRZYKŁADY MAPOWAŃ =====
			-- ---Akceptuj sugestię Copilot (inline)
			-- {
			-- 	".l",
			-- 	mode = "i",
			-- 	expr = true,
			-- 	function()
			-- 		return vim.fn["copilot#accept"]("")
			-- 	end,
			-- 	desc = "copilot: accept suggestion",
			-- },

			-- ---Toggle chat window (alternatywna metoda)
			-- vim.api.nvim_set_keymap(
			-- 	"n",
			-- 	"<space>cc",
			-- 	":copilot chat toggle<cr>",
			-- 	{ noremap = true, silent = true }
			-- ),

			-- ---Następna sugestia
			-- { ".n", mode = "i", "<plug>(copilot-next)", desc = "copilot: next suggestion" },

			-- ---Poprzednia sugestia
			-- { ".p", mode = "i", "<plug>(copilot-previous)", desc = "copilot: previous suggestion" },

			-- ---Odrzuć sugestię
			-- { ".d", mode = "i", "<plug>(copilot-dismiss)", desc = "copilot: dismiss suggestion" },

			-- ---Zaakceptuj słowo
			-- { "<ctrl>l", mode = "i", "<plug>(copilot-accept-word)", desc = "copilot: accept word" },

			-- ---Zaakceptuj linię
			-- { "<ctrl>k", mode = "i", "<plug>(copilot-accept-line)", desc = "copilot: accept line" },

			-- ---Status Copilot
			-- { ".s", mode = "n", ":copilot status<cr>", desc = "copilot: status" },

			-- ---Włącz Copilot
			-- { ".e", mode = "n", ":copilot enable<cr>" },

			-- ---Wyłącz Copilot
			-- { ".d", mode = "n", ":copilot disable<cr>" },
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

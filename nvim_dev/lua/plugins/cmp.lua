-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
-- SENIORSKI SETUP: NVIM 0.11 NATIVE SNIPPETS + LUASNIP FALLBACK
-- Plik: C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\plugins\snippets.lua
-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
-- https://grok.com/project/5976f874-e8f1-4b2e-9386-dbb4216e9f1b?tab=sources&chat=96739e16-1ac0-4258-bfd8-3ea7aad350e8&rid=c3522608-6c21-4a74-a7ca-33f12f3e5f58
--
return {
	-- ========== PLUGIN 1: LUASNIP (silnik dla custom snippet¢w) ==========
	{
		"L3MON4D3/LuaSnip",

		version = "2.*", -- najnowsza stabilna (2025 ¿ v2.3+)
		-- build = "make install_jsregexp", -- wymagane dla zaawansowanych regex w snippetach

		event = "InsertEnter",

		dependencies = {
			"rafamadriz/friendly-snippets",
			-- "nvim-snippets/nvim-snippets", -- Twój aktualny, ale skonfigurujemy go lepiej
		},

		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local sn = ls.snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
			-- ========== CONFIG ENGINE ==========
			-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
			ls.config.set_config({
				history = true, -- pami¿taj ostatni snippet w sesji
				updateevents = "TextChanged,TextChangedI", -- live update snippetów
				delete_check_events = "TextChanged,TextChangedI", -- auto-usuwanie pustych snippetów
				region_check_events = "CursorMoved,CursorMovedI",
				enable_autosnippets = true, -- autosnippets dzia¿aj¿ na spacj¿/enter
			})

			-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
			-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
			-- ========== EXTEND FILETYPES (all.lua dzia¿a wsz¿dzie) ==========
			-- SAFE: sprawd¿ czy modu¿ extras.filetype_functions istnieje
			local has_ft_funcs, ft_funcs = pcall(require, "luasnip.extras.filetype_functions")
			if has_ft_funcs then
				ls.config.set_config({
					load_ft_func = ft_funcs.extend_load_ft({
						["_"] = { "all" }, -- "_" = ka¿dy filetype dostaje "all"
					}),
				})
			else
				-- Fallback: r¿czne rozszerzenie (starsze wersje LuaSnip)
				ls.filetype_extend("_", { "all" })
			end

			-- ========== LOADERS ==========
			-- 1. Friendly-snippets (VSCode format) - lazy load
			require("luasnip.loaders.from_vscode").lazy_load()

			-- 2. W¿asne snippety (Lua format) - lazy load
			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "\\lua\\snippets" },
			})

			-- ========== KEYMAPS ==========
			-- ¿ LUASNIP keymaps (C-n/C-p dla choice, osobno od blink)
			vim.keymap.set({ "i", "s" }, "<C-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip: Next Choice" })

			vim.keymap.set({ "i", "s" }, "<C-p>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end, { silent = true, desc = "LuaSnip: Prev Choice" })
			-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true, desc = "LuaSnip: Expand/Jump Forward" })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true, desc = "LuaSnip: Jump Backward" })

			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip: Cycle Choices" })
		end,
	},
	-- ========== PLUGIN 2: BLINK.CMP (autocomplete engine faster thatn nvim-cmp) ==========
	-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿

	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "hide" },
				["<C-e>"] = { "hide" },

				-- ¿ ZATWIERDZANIE
				["<CR>"] = { "accept", "fallback" },
				-- Rozwi¿/Schowaj doc
				["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
				["<C-l>"] = { "accept", "fallback" },
				["<C-y>"] = { "select_and_accept" },

				-- ¿ NAWIGACJA (tylko stringi, NIE funkcje!)
				["<C-n>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
				["<C-p>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				-- SCROLL DOC
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
					-- ¿ TYLKO STRINGI (NIE funkcje!)
					["<C-n>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
					["<C-p>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
					["<Tab>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
					["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
					["<CR>"] = { "accept", "fallback" },
          ["<S-k>"] = { "show_documentation", "hide_documentation", "fallback" },
					["<C-l>"] = { "accept", "fallback" },
					["<C-y>"] = { "select_and_accept" },
				},
			},
			-- help and function parameters
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			-- W¿¿CZ DOKUMENTACJ¿/PREVIEW
			completion = {
				ghost_text = {
					enabled = true, -- pokazuje snippet "na szaro" przed zatwierdzeniem
				},
				trigger = {
					show_in_snippets = true, -- poka¿ podpowiedzi w snippetach
					show_on_blocked_trigger_characters = { " ", "\n", "\t" },
				},

				documentation = {
					auto_show = true, -- poka¿ automatycznie
					auto_show_delay_ms = 120, -- opó¿nienie 200ms
					window = {
						border = "rounded", -- zaokr¿glone rogi
						max_width = 60, -- mniejsza szeroko¿¿ (domy¿lnie 80)
						max_height = 20, -- mniejsza wysoko¿¿ (domy¿lnie 30)
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
			},
			-- ========== KLUCZOWE: Blink u¾ywa LuaSnip jako silnika ==========
			snippets = {
				preset = "luasnip", -- ? Blink czyta snippety przez LuaSnip API
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = { score_offset = 100 }, -- najwy¿szy
					snippets = { score_offset = 80 },
					path = { score_offset = 50 },
					buffer = { score_offset = 20 }, -- najni¿szy
				},
			},

			fuzzy = {
				implementation = "lua", -- zmieä na "fzf" je˜li masz fzf zainstalowane
			},
		},
	},
	¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿

	-- ========== PLUGIN 3: NATYWNE SNIPPETY (vim.snippet - Nvim 0.10+) ==========
	-- U¾ywamy <Tab> do skok¢w w snippetach od LSP
	-- {
	--   "garymjr/nvim-snippets", -- adapter dla friendly-snippets -> vim.snippet
	--   event = "InsertEnter",
	--   dependencies = { "rafamadriz/friendly-snippets" },
	--   opts = {
	--     friendly_snippets = true, -- ? ˆaduj friendly-snippets
	--     search_paths = { vim.fn.stdpath("config") .. "/snippets" }, -- wˆasne VSCode snippety
	--   },
	--   config = function(_, opts)
	--     require("snippets").setup(opts)
	--
	--     -- ========== KEYMAPS: NATYWNE SKOKI (vim.snippet) ==========
	--     vim.keymap.set({ "i", "s" }, "<Tab>", function()
	--       if vim.snippet.active({ direction = 1 }) then
	--         return "<Cmd>lua vim.snippet.jump(1)<CR>"
	--       else
	--         return "<Tab>"
	--       end
	--     end, { expr = true, silent = true, desc = "Snippet: Jump Forward" })
	--
	--     vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	--       if vim.snippet.active({ direction = -1 }) then
	--         return "<Cmd>lua vim.snippet.jump(-1)<CR>"
	--       else
	--         return "<S-Tab>"
	--       end
	--     end, { expr = true, silent = true, desc = "Snippet: Jump Backward" })
	--   end,
	-- },
}

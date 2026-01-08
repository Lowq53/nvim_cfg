return {}

-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\plugins\tmp_snipet.lua
--
-- ==========================================================================
-- MINIMALNA KONFIGURACJA BLINK.CMP + LUASNIP (NVIM 0.11)
-- ==========================================================================
--[[
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

-- 1. DEFINICJA TWOJEGO SNIPPETU (Nagłówek sekcji)
ls.add_snippets("all", {
	s("header_lsp", {
		t({
			"-- ======================== LSP & MASON ========================",
			"-- ═" .. string.rep("═", 75),
			"", -- pusta linia na końcu
		}),
	}),
})

-- 2. KONFIGURACJA BLINK (Aby widział ten snippet)
require("blink.cmp").setup({
	-- Ustawiamy LuaSnip jako źródło danych
	snippets = { preset = "luasnip" },

	-- Podstawowe mapowanie:
	-- Tab - wybiera podpowiedź
	-- Ctrl + k - skacze do przodu wewnątrz snippetu
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_and_accept", "fallback" },
		["<C-k>"] = { "snippet_forward", "fallback" },
		["<C-j>"] = { "snippet_backward", "fallback" },
	},

	-- Skąd Blink ma brać podpowiedzi?
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

-- 3. KEYMAP DO RĘCZNEGO ODPALANIA LUASNIP (Dla pewności)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
]]
--

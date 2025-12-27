-- ~/.config/nvim/luasnippets/all.lua
local ls = require("luasnip")
local s, t, c, sn = ls.snippet, ls.text_node, ls.choice_node, ls.snippet_node

local cfg = {
	w = 72,
	sep = {
		{ k = "h1", ch = "▰", n = "Block 1" },
		{ k = "h2", ch = "∎", n = "Square" },
		{ k = "h3", ch = "═", n = "Double" },
		{ k = "h4", ch = "─", n = "Thin" },
		{ k = "eq", ch = "=", n = "Equal" },
		{ k = "emd", ch = "—", n = "Em dash" },
		{ k = "und", ch = "‗", n = "Underscore" },
		{ k = "wave", ch = "﹋", n = "Wavy" },
		{ k = "wave2", ch = "◤◢◣◥", n = "Pattern" },
	},
}

local snips = {}

-- Bezpośrednie snippety
for _, v in ipairs(cfg.sep) do
	-- ✅ FIX: Proste powtórzenie bez dzielenia
	table.insert(snips, s(v.k, { t(string.rep(v.ch, cfg.w)) }, { desc = v.n }))
end

-- Menu sep
local choices = {}
for _, v in ipairs(cfg.sep) do
	table.insert(choices, sn(nil, { t(string.rep(v.ch, cfg.w)) }))
end
table.insert(snips, s("sep", { c(1, choices) }, { desc = "Menu (C-n/p)" }))

return snips

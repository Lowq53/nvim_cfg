-- ~/.config/nvim/luasnippets/all.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt).fmt
local i, f = ls.insert_node, ls.function_node
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

local snips = {
	s("ht", {
		-- Time, Date (YY) and separator
		f(function()
			return os.date("%H:%M %d %m %y / ")
		end),
		i(1, "Block 1"),
		t({ "", string.rep("▰", 72), "" }),
		i(0), -- Final jump here (below the line)
	}),
}

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

ls.add_snippets("markdown", {})

ls.add_snippets("all", { -- dla wszystkich typów plików
  s("to", fmt([[
    - [ ] {task}
      - ( ) {sub}
    ]], {
        task = i(1, "Task"),
        sub = i(2, "Subtask")
    })),
	s("todo", { t("- [] "), i(1) }),
})
return snips

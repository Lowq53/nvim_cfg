-- ~/.config/nvim/luasnippets/all.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i, f = ls.insert_node, ls.function_node
local s, t, c, sn, d = ls.snippet, ls.text_node, ls.choice_node, ls.snippet_node, ls.dynamic_node

-- ════════════════════════════════════════════════════════════════════════════
-- CONFIG
-- ════════════════════════════════════════════════════════════════════════════
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

-- ════════════════════════════════════════════════════════════════════════════
-- HELPERS
-- ════════════════════════════════════════════════════════════════════════════
local function sep_by_key(k)
	for _, v in ipairs(cfg.sep) do
		if v.k == k then
			return string.rep(v.ch, cfg.w)
		end
	end
	return string.rep("-", cfg.w)
end
local function pad_to_col(target_col)
	-- Pobieramy tekst w bieżącej linii przed kursorem
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local current_text = line:sub(1, col)

	local padding = target_col - #current_text
	if padding > 0 then
		return string.rep(" ", padding)
	else
		return " " -- Jeśli tekst jest za długi, dajemy tylko jedną spację
	end
end

local function multi_col_snippet(args, parent)
	local nodes = {}
	local total_width = 70
	local num_cols = tonumber(parent.snippet.trigger:match("%d+")) or 2
	local col_width = math.floor(total_width / num_cols)

	for j = 1, num_cols do
		-- Obliczamy ile spacji dodać przed tekstem (padding)
		-- Pierwsza kolumna zaczyna od 0, kolejne od wielokrotności col_width
		table.insert(
			nodes,
			f(function()
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local target = (j - 1) * col_width
				local padding = target - col
				return padding > 0 and string.rep(" ", padding) or ""
			end)
		)

		-- Dodajemy pole do wpisywania
		table.insert(nodes, i(j, j == num_cols and "opis" or "tekst " .. j))
	end

	return sn(nil, nodes)
end

local function is_comment_file()
	local ft = vim.bo.filetype
	local no_comment_fts = { "markdown", "text", "vim", "gitcommit", "" }
	for _, v in ipairs(no_comment_fts) do
		if ft == v then
			return false
		end
	end
	return true
end

local function comment_prefix()
	if not is_comment_file() then
		return ""
	end
	local cs = vim.bo.commentstring or "# %s"
	local pref = cs:match("^([^%%*%s]+)") or "--"
	if not pref:match("%s$") then
		pref = pref .. " "
	end
	return pref
end

local function comment_line(width, char)
	local pref = comment_prefix()
	local line = string.rep(char, width)
	return pref .. line
end
local function bar()
	return string.rep("═", (cfg and cfg.w) or 72)
end

-- ════════════════════════════════════════════════════════════════════════════
-- SNIPPETS
-- ════════════════════════════════════════════════════════════════════════════
local snips = {
	-- Time, Date and separator
	s("ht", {
		f(function()
			return os.date("%H:%M %d %m %y / ")
		end),
		i(1, "Block 1"),
		t({ "", string.rep("▰", 72), "" }),
		i(0),
	}),
}

-- Direct separator snippets
for _, v in ipairs(cfg.sep) do
	table.insert(snips, s(v.k, { t(string.rep(v.ch, cfg.w)) }, { desc = v.n }))
end

-- Menu separator
local choices = {}
for _, v in ipairs(cfg.sep) do
	table.insert(choices, sn(nil, { t(string.rep(v.ch, cfg.w)) }))
end
table.insert(snips, s("sep", { c(1, choices) }, { desc = "Menu (C-n/p)" }))

-- Header with separator
table.insert(
	snips,
	s(
		"header",
		fmt(
			[[
{sep}
{pref}TITLE: {title}
{pref}DATE:  {date}
{sep}
]],
			{
				sep = f(function()
					return comment_line(72, "-")
				end),
				pref = f(comment_prefix),
				title = i(1, "NAGŁÓWEK"),
				date = f(function()
					return os.date("%Y-%m-%d")
				end),
			}
		)
	)
)
-- ════════════════════════════════════════════════════════════════════════════
-- TODO SNIPPETS - [ ] and ( )
-- ════════════════════════════════════════════════════════════════════════════

-- Basic todo with choice [ ] or ( )
table.insert(
	snips,
	s("t", {
		f(comment_prefix),
		t("- "),
		c(1, {
			t("[] "),
			t("() "),
		}),
		i(2, "zadanie"),
	}, { desc = "- [] lub () checkbox" })
)

-- Alias: todo
table.insert(
	snips,
	s("todo", {
		f(comment_prefix),
		t("- "),
		c(1, {
			t("[] "),
			t("() "),
		}),
		i(2, "zadanie"),
	}, { desc = "alias do t" })
)

-- Indented todo (2 spaces)
table.insert(
	snips,
	s("t1", {
		f(comment_prefix),
		t("  - "),
		c(1, {
			t("[] "),
			t("() "),
		}),
		i(2, "podpunkt"),
	}, { desc = "  - [] z wcięciem 2 spacje" })
)

-- Double indented (4 spaces)
table.insert(
	snips,
	s("t2", {
		f(comment_prefix),
		t("    - "),
		c(1, {
			t("[] "),
			t("() "),
		}),
		i(2, "głębszy poziom"),
	}, { desc = "    - [ ] wcięcie 4 spacje" })
)

-- Extended todo with sub-item
table.insert(
	snips,
	s("todo2", {
		f(comment_prefix),
		t("- "),
		c(1, {
			t("[] "),
			t("() "),
		}),
		i(2, "główne zadanie"),
		t({ "", "" }),
		f(comment_prefix),
		t("  - "),
		c(3, {
			t("( ) "),
			t("[ ] "),
		}),
		i(4, "podpunkt"),
		c(5, {
			t(""),
			sn(nil, {
				t({ "", "" }),
				f(comment_prefix),
				t("  - ( ) "),
				i(1, "kolejny podpunkt"),
			}),
		}),
	}, { desc = "Todo z zagnieżdżonymi punktami" })
)

-- ════════════════════════════════════════════════════════════════════════════
-- section sinpest
-- ════════════════════════════════════════════════════════════════════════════
table.insert(
	snips,
	s(
		"section",
		fmt(
			[[
{pref}# {title}
{sep1}
{cursor}
{sep2}
]],
			{
				pref = f(comment_prefix),
				title = i(1, "SECTION NAME"),
				sep1 = f(function()
					return comment_line(72, "▰")
				end),
				cursor = i(0),
				sep2 = f(function()
					return comment_line(72, "═")
				end),
			}
		),
		{ desc = "Section with double separator" }
	)
)

table.insert(
	snips,
	s(
		"section2",
		fmt(
			[[
{pref}# {title}
{sep1}
{cursor}
{sep2}
]],
			{
				pref = f(comment_prefix),
				title = i(1, "SECTION NAME"),
				sep1 = f(function()
					return comment_line(72, "═")
				end),
				cursor = i(0),
				sep2 = f(function()
					return comment_line(72, "─")
				end),
			}
		),
		{ desc = "Section with double separator" }
	)
)
-- ════════════════════════════════════════════════════════════════════════════
-- section sinpest specyfied column 70
-- ════════════════════════════════════════════════════════════════════════════
-- Snippet pod <Ctrl-b> (kolumna 70)
table.insert(
	snips,
	s("cb", {
		f(function()
			return pad_to_col(70)
		end),
		f(comment_prefix),
		i(0),
	}, { desc = "Doskocz do 70 kolumny i zacznij komentarz" })
)

-- Snippet <keymap> (kolumna 35)
table.insert(
	snips,
	s("km", {
		f(function()
			return pad_to_col(35)
		end),
		t("<keymap> "),
		i(0),
	}, { desc = "Wstaw <keymap> na 35 pozycji" })
)

-- Dynamiczny podział na X kolumn (np. c2, c3, c4)
table.insert(
	snips,
	s({ trig = "c(%d+)", regTrig = true }, {
		d(1, multi_col_snippet),
	}, { desc = "Podział linii na X kolumn (max 70 znaków)" })
)

-- Twój specyficzny przykład: sa (Shortcut & Annotation)
-- [Tekst] (0) -> [Keymap] (35) -> [Opis] (70)
table.insert(
	snips,
	s(
		"sa",
		fmt("{t1}{p1}<keymap> {p2}{pref}{t2}", {
			t1 = i(1, "komenda"),
			p1 = f(function()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				return string.rep(" ", math.max(1, 35 - col))
			end),
			p2 = f(function()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				return string.rep(" ", math.max(1, 70 - col))
			end),
			pref = f(comment_prefix),
			t2 = i(2, "opis"),
		})
	)
)

--  ═══════════════════════════════════════════════════════════════════════════
-- REGISTER ALL SNIPPETS
-- ════════════════════════════════════════════════════════════════════════════
-- -- ════════════════════════════════════════════════════════════════════════════
-- CHAPTER — separator dopasowany do cfg.w
-- ════════════════════════════════════════════════════════════════════════════
table.insert(
	snips,
	s({ trig = "chapter", dscr = "Chapter: h3 tytuł h3 treść h4" }, {
		f(comment_prefix),
		f(function()
			return sep_by_key("h3")
		end),
		t({ "", "" }),
		f(comment_prefix),
		t("# "),
		i(1, "Chapter title"),
		t({ "", "" }),
		f(comment_prefix),
		f(function()
			return sep_by_key("h3")
		end),
		t({ "", "" }),
		i(2, "treść"),
		t({ "", "" }),
		f(comment_prefix),
		f(function()
			return sep_by_key("h4")
		end),
		t({ "", "" }),
		i(0),
	})
)

return snips

local ls = require("luasnip")
local s, t, i, f = ls.snippet, ls.text_node, ls.insert_node, ls.function_node

return {
	s("sepl", {
		t({
			"═══════════════════════════════════════════════════════════════════════════",
			"",
		}),
	}),

	s("req", { t("local "), i(1, "mod"), t(' = require("'), i(2, "module"), t('")') }),
	s("timeHMS*", { f(function()
		return os.date("%H:%M:%S")
	end) }),
	s("todo", { t("- [ ] TODO ("), f(function()
		return os.date("%H:%M %d.%m.%y")
	end), t(")") }),
	s("req", {
		t("local "),
		i(1, "mod"),
		t(' = require("'),
		i(2, "module"),
		t('")'),
	}),

	s("fn", {
		t("function "),
		i(1, "name"),
		t("()"),
		t({ "", "  " }),
		i(2),
		t({ "", "end" }),
	}),
	-- time only
	s("timeHMS*", {
		f(function()
			return os.date("%H:%M:%S")
		end),
	}),

	-- date + time

	s("datetime*", {
		f(function()
			return os.date("%Y-%m-%d %H:%M:%S")
		end),
	}),

	-- TODO snippet
	s("todo", {
		t("- [ ] TODO ("),
		f(function()
			return os.date("%H:%M %d.%m.%y")
		end),
		t(")"),
	}),

	s("header_lsp", {
		t({
			"-- ═══════════════════════════════════════════════════════════════════════════",
			"-- ================================= SNIPPETS ================================",
			"-- ═══════════════════════════════════════════════════════════════════════════",
			"",
		}),
	}),
}

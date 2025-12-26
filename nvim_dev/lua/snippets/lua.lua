local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
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
}


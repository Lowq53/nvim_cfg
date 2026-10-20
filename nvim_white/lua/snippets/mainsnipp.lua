-- ~/.config/nvim/snippets/all.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	-- Podstawowy snippet z hashami
	s("test", {
		t("####"),
		t({ "", "#" }),
		i(1, "wstawianie tekstu"), -- pole do edycji
		t({ "", "####" }),
	}),

	-- Prosty separator
	s("sep", {
		t("#==="),
	}),

	-- Bardziej zaawansowany - z formatowaniem
	s(
		"header",
		fmt(
			[[
####
#{}
####
]],
			{
				i(1, "wstawianie tekstu"),
			}
		)
	),

	-- Snippet z datą
	s("date", {
		f(function()
			return os.date("%Y-%m-%d")
		end, {}),
	}),

	-- Snippet z wieloma polami
	s(
		"todo",
		fmt(
			[[
####
#TODO: {}
#Data: {}
#Priorytet: {}
####
]],
			{
				i(1, "opis zadania"),
				f(function()
					return os.date("%Y-%m-%d")
				end, {}),
				i(2, "normalny"),
			}
		)
	),

	-- Snippet z wyborem
	s("comment", {
		t("# "),
		i(1, "komentarz"),
		t(" "),
		c(2, {
			t("TODO"),
			t("FIXME"),
			t("NOTE"),
			t("HACK"),
		}),
	}),
}

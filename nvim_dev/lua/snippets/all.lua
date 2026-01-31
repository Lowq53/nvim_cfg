-- ~/.config/nvim/luasnippets/all.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i, f = ls.insert_node, ls.function_node
local s, t, c, sn = ls.snippet, ls.text_node, ls.choice_node, ls.snippet_node

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
local function is_comment_file()
  local ft = vim.bo.filetype
  local no_comment_fts = { "markdown", "text", "vim", "gitcommit", "" }
  for _, v in ipairs(no_comment_fts) do
    if ft == v then return false end
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
table.insert(snips, s(
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
))
-- ════════════════════════════════════════════════════════════════════════════
-- TODO SNIPPETS - [ ] and ( )
-- ════════════════════════════════════════════════════════════════════════════

-- Basic todo with choice [ ] or ( )
table.insert(snips, s("t", {
  f(comment_prefix),
  t("- "),
  c(1, {
    t("[] "),
    t("() "),
  }),
  i(2, "zadanie"),
}, { desc = "- [] lub () checkbox" }))

-- Alias: todo
table.insert(snips, s("todo", {
  f(comment_prefix),
  t("- "),
  c(1, {
    t("[] "),
    t("() "),
  }),
  i(2, "zadanie"),
}, { desc = "alias do t" }))

-- Indented todo (2 spaces)
table.insert(snips, s("t1", {
  f(comment_prefix),
  t("  - "),
  c(1, {
    t("[] "),
    t("() "),
  }),
  i(2, "podpunkt"),
}, { desc = "  - [] z wcięciem 2 spacje" }))

-- Double indented (4 spaces)
table.insert(snips, s("t2", {
  f(comment_prefix),
  t("    - "),
  c(1, {
    t("[] "),
    t("() "),
  }),
  i(2, "głębszy poziom"),
}, { desc = "    - [ ] wcięcie 4 spacje" }))

-- Extended todo with sub-item
table.insert(snips, s("todo2", {
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
}, { desc = "Todo z zagnieżdżonymi punktami" }))

-- ════════════════════════════════════════════════════════════════════════════
-- section sinpest
-- ════════════════════════════════════════════════════════════════════════════
table.insert(snips, s(
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
))

table.insert(snips, s(
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
))

-- ════════════════════════════════════════════════════════════════════════════
-- REGISTER ALL SNIPPETS
-- ════════════════════════════════════════════════════════════════════════════
ls.add_snippets("all", snips)

return snips

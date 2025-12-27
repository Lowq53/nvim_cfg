local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i, f = ls.insert_node, ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

-- Konfiguracja: łatwo zmieniaj długość i znaki
local config = {
  width = 72,
  -- Dodawaj nowe separatory tutaj ↓
  separators = {
    { key = "h1", char = "▰", name = "Block art 1 (▰)", multiline = false },
    { key = "h2", char = "∎", name = "Square block (∎)", multiline = false },
    { key = "h3", char = "─", name = "Thin line (─)", multiline = false },
    { key = "dbl", char = "═", name = "Double bold (═)", multiline = false },
    { key = "eq", char = "=", name = "Double line (=)", multiline = false },
    { key = "emd", char = "—", name = "Em dash (—)", multiline = false },
    { key = "und", char = "‗", name = "Double underscore (‗)", multiline = false },
    { key = "wave", char = "﹋", name = "Wavy line (﹋)", multiline = false },
    { key = "wave2", char = "◤◢◣◥", name = "Wave pattern", multiline = true },
  },
}

-- Funkcja generator snippetów (DRY!)
local function create_sep_snippet(key, char, name, multiline)
  local nodes = {}

  if multiline then
    -- Wieloliniowy pattern - powtarza się poziomo
    local pattern = string.rep(char, math.floor(config.width / char:len()))
    nodes = { t(pattern) }
  else
    -- Pojedynczy znak powtarzany
    nodes = { t(string.rep(char, config.width)) }
  end

  -- Dodaj pustą linię na końcu dla lepszego formatowania
  table.insert(nodes, t(""))

  return s(key, nodes, { desc = name })
end

-- Główny return z automatycznie generowanymi snippetami
local snippets = {}
for _, sep in ipairs(config.separators) do
  table.insert(snippets, create_sep_snippet(sep.key, sep.char, sep.name, sep.multiline))
end

-- ✅ POPRAWNY uniwersalny snippet
table.insert(
  snippets,
  s("sep", {
    i(1, { "h1", "h2", "h3", "eq", "dash", "emd", "und", "wave", "dbl", "art1", "art2", "wave2" }),
    t(""),
  }, {
    desc = "Universal separator picker",
  })
)

return snippets

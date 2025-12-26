local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i, f = ls.insert_node, ls.function_node

return {
  s("sepa", {
    t({
      "═══════════════════════════════════════════════════════════════════════════",
      "",
    }),
  }),

  -- Double line (=)
  s("sep1", { t(string.rep("=", 72)) }),
  -- Thin line (─)
  s("sep2", { t(string.rep("─", 72)) }),
  -- Bold dash (—)
  s("sep3", { t(string.rep("—", 72)) }),
  -- Double underscore (‗)
  s("sep4", { t(string.rep("‗", 72)) }),
  -- Wavy line (﹋)
  s("sep5", { t(string.rep("﹋", 72)) }),
  -- Double bold line (═)
  s("sep6", { t(string.rep("═", 72)) }),
}

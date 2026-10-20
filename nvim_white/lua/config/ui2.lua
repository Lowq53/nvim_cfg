local M = {}

-- Kolory inspirowane Tokyo Night (zmodyfikowane dla lepszej widoczności)
local colors = {
  bg = "#1a1b26",
  fg = "#a9b1d6",
  comment = "#FFE4a2",
  comment = "#FFE4a2",
  keyword = "#7aa2f7",
  function_ = "#7dcfff",
  string = "#9ece6a",
  number = "#ff9e64",
  operator = "#bb9af7",
  error = "#f7768e",
  warning = "#e0af68",
  hint = "#73daca",
  info = "#b4f9f8",
  cursor = "#f7768e",
  visual = "#33467c",
  line_nr = "#7aa2f7",
  cursor_line_nr = "#FA5600",
}

-- Główne funkcje
function M.set_transparency()
  -- Ustaw przezroczyste tła dla grup
  local transparent_groups = {
    "Normal", "NormalNC", "NormalFloat", "FloatBorder",
    "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
    "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder",
    "TelescopeResultsNormal", "TelescopeResultsBorder", "TelescopePreviewNormal",
    "WhichKeyFloat", "NvimTreeNormal", "NvimTreeNormalNC", "CmpPmenu",
    "NoicePopup", "MsgArea", "StatusLine", "StatusLineNC",
    "WinBar", "FoldColumn", "VertSplit", "WinSeparator", "SignColumn", "EndOfBuffer",
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

function M.set_tokyonight_colors()
  -- Ustaw kolory składni
  vim.api.nvim_set_hl(0, "Normal",      { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "Comment",     { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, "Keyword",     { fg = colors.keyword, bold = true })
  vim.api.nvim_set_hl(0, "Function",    { fg = colors.function_, bold = true })
  vim.api.nvim_set_hl(0, "String",      { fg = colors.string })
  vim.api.nvim_set_hl(0, "Number",      { fg = colors.number })
  vim.api.nvim_set_hl(0, "Operator",    { fg = colors.operator })
  vim.api.nvim_set_hl(0, "LineNr",      { fg = colors.line_nr })
  vim.api.nvim_set_hl(0, "CursorLineNr",{ fg = colors.cursor_line_nr, bold = true })
  vim.api.nvim_set_hl(0, "Cursor",      { fg = colors.bg, bg = colors.cursor })
  vim.api.nvim_set_hl(0, "Visual",      { bg = colors.visual })
  vim.api.nvim_set_hl(0, "Error",       { fg = colors.error, bold = true })
  vim.api.nvim_set_hl(0, "WarningMsg",  { fg = colors.warning, bold = true })
  vim.api.nvim_set_hl(0, "Hint",        { fg = colors.hint })
  vim.api.nvim_set_hl(0, "Info",        { fg = colors.info })

  -- Kursor (pomarańczowy tło, czarny tekst)
  vim.api.nvim_set_hl(0, "Cursor", {
    fg = "#000000",  -- Czarny tekst
    bg = "#FF5600",  -- Pomarańczowe tło
    -- blend = 30,    -- Opcjonalna przezroczystość (0-100)
  }) 
  -- Dla trybu insert/visual
  vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#FF5600" })
  vim.api.nvim_set_hl(0, "vCursor", { fg = "#000000", bg = "#FF5600" }) 

  -- Pasek statusu
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "#197083", fg = "#FFFFFF", bold = true })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#0F4C5C", fg = "#CCCCCC" })
 -- Mode indicator (np. [NORMAL])
  -- Mode indicator (np. [NORMAL])
  vim.api.nvim_set_hl(0, "StatusLineMode", { bg = "#1E90FF", fg = "#000000" })
  
  -- Plik i ścieżka
  vim.api.nvim_set_hl(0, "StatusLineFilename", { bg = "#197083", fg = "#FFFFFF" })
  
  -- Linia i kolumna
  vim.api.nvim_set_hl(0, "StatusLinePosition", { bg = "#135D6B", fg = "#FFFFFF" }) vim.api.nvim_set_hl(0, "StatusLineMode", { bg = "#1E90FF", fg = "#000000" })
  
  -- Plik i ścieżka
  vim.api.nvim_set_hl(0, "StatusLineFilename", { bg = "#197083", fg = "#FFFFFF" })
  
  -- Linia i kolumna
  vim.api.nvim_set_hl(0, "StatusLinePosition", { bg = "#135D6B", fg = "#FFFFFF" })
end

-- Przełącznik przezroczystości (do mapowania klawiszy)
function M.toggle_transparency()
  M._transparent = not (M._transparent == nil and true or M._transparent)
  local bg = M._transparent and "none" or colors.bg

  vim.api.nvim_set_hl(0, "Normal", { bg = bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg })
end

-- Automatyczne zastosowanie ustawień przy zmianie motywu
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    M.set_transparency()
    M.set_tokyonight_colors()
  end,
})

-- Zastosuj ustawienia przy ładowaniu
M.set_transparency()
M.set_tokyonight_colors()

return M

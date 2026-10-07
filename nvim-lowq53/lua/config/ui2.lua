
return function()
  -- Globalna zmienna: czy przezroczystość aktywna
  _G.transparent_enabled = true

  -- Grupy do modyfikacji tła
  local groups_to_make_transparent = {
    "Normal", "NormalNC", "NormalFloat", "FloatBorder",
    "TelescopeNormal", "TelescopeBorder",
    "TelescopePromptNormal", "TelescopePromptBorder",
    "TelescopeResultsNormal", "TelescopeResultsBorder",
  }

  -- Funkcja: ustaw przezroczystość
  function _G.set_transparency()
    local bg = _G.transparent_enabled and "none" or "#1a1b26"
    for _, group in ipairs(groups_to_make_transparent) do
      pcall(vim.api.nvim_set_hl, 0, group, { bg = bg })
    end
  end

  -- Funkcja: niestandardowe kolory składni
  function _G.set_custom_syntax_colors()
    vim.api.nvim_set_hl(0, "Normal",      { fg = "#d8dee9", bg = "#0f111a" })
    vim.api.nvim_set_hl(0, "Comment",     { fg = "#BDCCD6", italic = true })
    vim.api.nvim_set_hl(0, "Keyword",     { fg = "#7c3b54", bold = true })
    vim.api.nvim_set_hl(0, "Function",    { fg = "#8be9fd", bold = true })
    vim.api.nvim_set_hl(0, "String",      { fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "Number",      { fg = "#fab387" })
    vim.api.nvim_set_hl(0, "Operator",    { fg = "#f2cdcd" })
    vim.api.nvim_set_hl(0, "LineNr",      { fg = "#4b5263" })
    vim.api.nvim_set_hl(0, "Cursor",      { fg = "#0f111a", bg = "#f38ba8" })
    vim.api.nvim_set_hl(0, "Visual",      { bg = "#313244" })
    vim.api.nvim_set_hl(0, "Error",       { fg = "#ce3d54", bold = true })
    vim.api.nvim_set_hl(0, "WarningMsg",  { fg = "#f9e2af", bold = true })
    vim.api.nvim_set_hl(0, "Hint",        { fg = "#89dceb" })
    vim.api.nvim_set_hl(0, "Info",        { fg = "#94e2d5" })
  end

  -- Funkcja: przełącz przezroczystość (np. pod mapę klawiszy)
  _G.toggle_transparency = function()
    _G.transparent_enabled = not _G.transparent_enabled
    _G.set_transparency()
    _G.set_custom_syntax_colors()
  end

  -- Autocommand: przy zmianie motywu ponów konfigurację
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      _G.set_transparency()
      _G.set_custom_syntax_colors()
    end,
  })

  -- Ustaw motyw, kolory i przezroczystość na start
  vim.cmd.colorscheme("tokyonight")
  _G.set_transparency()
  _G.set_custom_syntax_colors()
end

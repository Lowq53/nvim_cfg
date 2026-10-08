-- ~/.config/nvim/lua/ui.lua
-- Stylizacja i przezroczystość UI

return function() -- Ten plik powinien zwracać funkcję, która zostanie wywołana

  -- Funkcja do ustawiania przezroczystości dla różnych elementów UI
  --
  local function set_transparency()
    -- Standardowe tło edytora i głównych okien
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Normal non-current window background

    -- Lista grup, które chcemy ustawić na przezroczyste tło
    local groups_to_make_transparent = {
      "NormalFloat",        -- Tło pływających okien (np. LSP, WhichKey)
      "FloatBorder",        -- Ramka pływających okien
      "Pmenu",              -- Menu podpowiedzi (np. nvim-cmpr
      "PmenuSel",           -- Wybrana pozycja w menu podpowiedzi
      "PmenuSbar",          -- Pasek przewijania menu
      "PmenuThumb",         -- Kciuk paska przewijania menu
      "TelescopeNormal",    -- Główne tło okna Telescope
      "TelescopeBorder",    -- Ramka okna Telescope
      "TelescopePromptNormal", -- Tło paska wprowadzania w Telescope
      "TelescopePromptBorder", -- Ramka paska wprowadzania w Telescope
      "TelescopeResultsNormal", -- Tło wyników w Telescope
      "TelescopeResultsBorder", -- Ramka wyników w Telescope
      "TelescopePreviewNormal", -- Tło podglądu w Telescope
      "WhichKeyFloat",      -- Tło okna WhichKey
      "NvimTreeNormal",     -- Tło nvim-tree
      "NvimTreeNormalNC",   -- Tło nvim-tree w nieaktywnym oknie
      "CmpPmenu",           -- Główna grupa dla menu nvim-cmp
      "NoicePopup",         -- Jeśli używasz Noice.nvim dla powiadomień
      "MsgArea",            -- Obszar wiadomości
      "StatusLine",         -- Pasek statusu
      "StatusLineNC",       -- Pasek statusu w nieaktywnym oknie
      "WinBar",             -- Pasek tytułowy okna (jeśli używasz)
      "FoldColumn",         -- Kolumna z symbolami zwijania kodu
      "VertSplit",          -- Pionowe linie podziału okien
      "WinSeparator",       -- Separator okien (podobnie do VertSplit)
      "SignColumn",         -- Kolumna ze znakami (np. od diagnostyki, git-signs)
      "EndOfBuffer",        -- Znak ~ na końcu bufora
    }

    -- Ustaw tło na "none" dla wszystkich zdefiniowanych grup
    for _, group_name in ipairs(groups_to_make_transparent) do
      -- Używamy pcall, aby uniknąć błędów, jeśli jakaś grupa nie istnieje
      pcall(vim.api.nvim_set_hl, 0, group_name, { bg = "none" })
    end

    -- Styl dla linii numerów
    local c = {
      nb_colors = "#657573"
    }
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = c.nb_colors })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#4dddf0", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = c.nb_colors })
  end -- Koniec `set_transparency` function

  -- Funkcja do ustawiania niestandardowych kolorów składni (jeśli masz, wstaw tutaj)
  local function set_custom_syntax_colors()
    -- Przykładowe zmiany kolorów składni:
    -- vim.api.nvim_set_hl(0, "Statement", { fg = "#FF00FF", bold = true })
    -- vim.api.nvim_set_hl(0, "Function", { fg = "#00FFFF", italic = true })
    -- vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFF00" })
    -- vim.api.nvim_set_hl(0, "Comment", { fg = "#888888", italic = true })
  end -- Koniec `set_custom_syntax_colors` function

  -- ================================================================
  -- Autocommands i globalne funkcje
  -- ================================================================

  -- Automatycznie ustaw przezroczystość i niestandardowe kolory po załadowaniu motywu
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      set_transparency()
      -- Wywołaj set_custom_syntax_colors tylko jeśli funkcja istnieje
      if set_custom_syntax_colors then set_custom_syntax_colors() end
    end,
  }) -- Koniec autocmd "ColorScheme"

  -- Przełącznik przezroczystości (do użytku z mapowaniem klawiszy)
  _G.transparent_enabled = true -- Globalna zmienna do śledzenia stanu
  _G.toggle_transparency = function()
    _G.transparent_enabled = not _G.transparent_enabled
    local bg_color = _G.transparent_enabled and "none" or "#1a1b26" -- Twój preferowany kolor tła, gdy nieprzezroczyste

    -- Ustawia Normal, NormalFloat i ich obramowania na nowy kolor
    vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg_color })


  vim.cmd.colorscheme("akatsuki")
  
  vim.api.nvim_set_hl(0, "Normal",      { fg = "#d8dee9", bg = "#0f111a" })
  vim.api.nvim_set_hl(0, "Comment",     { fg = "#FFE462", italic = true })
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




    -- Iteruje przez te same grupy co `set_transparency`
    for _, group_name in ipairs(groups_to_make_transparent) do
      pcall(vim.api.nvim_set_hl, 0, group_name, { bg = bg_color })
    end

    -- Jeśli włączamy przezroczystość, upewnij się, że wszystkie niestandardowe
    -- ustawienia kolorów składni również się odświeżą (jeśli miałeś)
    if _G.transparent_enabled then
      set_transparency() -- Ponowne wywołanie, aby zapewnić, że wszystkie grupy są "none"
      if set_custom_syntax_colors then set_custom_syntax_colors() end
    end
  end -- Koniec `_G.toggle_transparency` function

  -- Usuń `vim.opt.termguicolors` i `vim.opt.background` stąd.
  -- Powinny być w `init.lua` lub `lua/config/options.lua` na początku.
  -- Ich miejsce jest na samej górze pliku, aby Neovim wiedział o nich zanim cokolwiek się załaduje.
  -- Poniższe linie są PRZYKŁADEM, jak to powinno być, ALE USUŃ JE Z TEGO PLIKU.
  -- vim.opt.termguicolors = true
  -- vim.opt.background = "dark"

  -- Pamiętaj, aby przenieść to mapowanie klawiszy do `lua/keymaps.lua`
  -- vim.keymap.set('n', '<leader>ut', _G.toggle_transparency, { desc = 'Toggle transparency' })

  -- ================================================================
  -- Wywołanie funkcji przy ładowaniu pliku (aby ustawić kolory od razu)
  -- ================================================================
  -- Ważne: Wywołaj te funkcje raz na początku, aby ustawić kolory
  -- po załadowaniu Twojego ui.lua przez lazy.nvim.
  set_transparency()
  if set_custom_syntax_colors then set_custom_syntax_colors() end

end -- Koniec głównego 'return function()'

--c:/Users/LOWq_53/AppData/Local/nvim_dev/lua/config/ui.lua
local M = {}

local function set_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

  local groups = {
    "NormalFloat", "FloatBorder", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
    "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder",
    "TelescopeResultsNormal", "TelescopeResultsBorder", "TelescopePreviewNormal",
    "WhichKeyFloat", "NvimTreeNormal", "NvimTreeNormalNC", "CmpPmenu", "NoicePopup",
    "MsgArea", "StatusLine", "StatusLineNC", "WinBar", "FoldColumn", "VertSplit",
    "WinSeparator", "SignColumn", "EndOfBuffer",
    "LazyNormal", "LazyButton", "LazyButtonActive", "LazyH1", "LazyH2",
    "LazySpecial", "LazyProp", "LazyValue", "LazyDir", "LazyUrl",
    "LazyCommit", "LazyNoCond", "LazyLocal",
  }

  for _, group in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, group, { bg = "none" })
  end

  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#657573" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#4dddf0", bg = "none", bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#657573" })
end

local function set_custom_colors()
  vim.api.nvim_set_hl(0, "Normal", { fg = "#d8dee9", bg = "none" })
  vim.api.nvim_set_hl(0, "Comment", { fg = "#d4a017", italic = true })
  vim.api.nvim_set_hl(0, "Keyword", { fg = "#7c3b54", bold = true })
  vim.api.nvim_set_hl(0, "Function", { fg = "#8be9fd", bold = true })
  vim.api.nvim_set_hl(0, "String", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "Number", { fg = "#fab387" })
  vim.api.nvim_set_hl(0, "Operator", { fg = "#f2cdcd" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#4b5263" })
  vim.api.nvim_set_hl(0, "Cursor", { fg = "#0f111a", bg = "#f38ba8" })
  vim.api.nvim_set_hl(0, "Visual", { bg = "#313244" })
  vim.api.nvim_set_hl(0, "Error", { fg = "#ce3d54", bold = true })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#f9e2af", bold = true })
  vim.api.nvim_set_hl(0, "Hint", { fg = "#89dceb" })
  vim.api.nvim_set_hl(0, "Info", { fg = "#94e2d5" })
end

function M.setup()
  vim.opt.termguicolors = true
  
  -- Załaduj colorscheme
  vim.cmd.colorscheme("tokyonight-moon")
  
  -- Ustaw custom kolory
  set_custom_colors()
  
  -- Zastosuj transparency
  set_transparency()
  
  -- Autocmd dla zmiany colorscheme
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      set_custom_colors()
      set_transparency()
    end,
  })
  
  -- Toggle transparency funkcja
  _G.transparent_enabled = true
  _G.toggle_transparency = function()
    _G.transparent_enabled = not _G.transparent_enabled
    local bg = _G.transparent_enabled and "none" or "#0f111a"
    
    vim.api.nvim_set_hl(0, "Normal", { bg = bg })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
    
    if _G.transparent_enabled then
      set_transparency()
    end
  end
end

return M

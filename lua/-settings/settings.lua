local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "PmenuSel",
  "PmenuSbar",
  "PmenuThumb",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "WhichKeyFloat",
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "CmpPmenu",             -- nvim-cmp menu
  "NoicePopup",           -- jeśli używasz Noice.nvim
  "MsgArea",
  "StatusLine",
  "WinBar"
}

for _, group in ipairs(groups) do
  pcall(vim.api.nvim_set_hl, 0, group, { bg = "none" })
end
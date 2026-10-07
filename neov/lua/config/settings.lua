-- lua/config/settings.lua
return function()
  vim.opt.termguicolors = true
  vim.opt.background = "dark"

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.mouse = "a"
  vim.opt.clipboard = "unnamedplus"

  vim.opt.splitright = true
  vim.opt.splitbelow = true

  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true

  vim.opt.undofile = true
  vim.opt.swapfile = false
end

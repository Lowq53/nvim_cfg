-- 1. Integracja ze schowkiem systemowym
-- Dzięki temu każda operacja 'y', 'd', 'p' domyślnie gada z Windowsem/Linuxem
vim.opt.clipboard = "unnamedplus"

vim.cmd.colorscheme("unokai")
vim.opt.number = true
-- ignoring case sensivity
vim.opt.ignorecase = true
vim.opt.rnu = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.opt.relativenumber = true
-- vim.opt.relativenumber = false
-- lua vim.g.relativenumber = false
-- showek sytemowy + *
--reg

-- c:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\config\settings.lua
local opt = vim.opt

-- ===== Podstawowe zawijanie ===== 
opt.wrap = true                -- Włącz zawijanie wierszy
opt.linebreak = true           -- Nie łam słów w połowie (zawijaj na spacjach/znakach interpunkcyjnych)
opt.breakindent = true         -- Zawinięte linie zachowują to samo wcięcie co linia bazowa
opt.copyindent = true          -- Kopiuj strukturę wcięć przy nowej linii
-- 2. Estetyka zawijania (Protip: dodanie symbolu na początku zawiniętej linii)
opt.showbreak = "↪ "           -- Znak wyświetlany na początku zawiniętej części wiersza

-- ===== CORE OPTIONS =====
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- ===== UNDO (wymagane dla UndoTree) =====
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ===== SEARCH =====
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- ===== LEADERS =====
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- c:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\config\settings.lua
local opt = vim.opt

-- Force UTF-8 encoding and Unix line endings
-- ═══════════════════════════════════════════════════════════════════════════

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix" -- Fixes ^M issues

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- chunk-level tylko w tym pliku
-- local vks = vim.keympap.set
-- PWSH
-- ... inne ustawienia Vima (vim.opt)
-- Za┼éaduj konfiguracj─Ö LazyVim z osobnego pliku

-- ===== Podstawowe zawijanie =====
-- ═══════════════════════════════════════════════════════════════════════════

opt.wrap = true -- Włącz zawijanie wierszy
opt.linebreak = true -- Nie łam słów w połowie (zawijaj na spacjach/znakach interpunkcyjnych)
opt.breakindent = true -- Zawinięte linie zachowują to samo wcięcie co linia bazowa
opt.copyindent = true -- Kopiuj strukturę wcięć przy nowej linii
-- 2. Estetyka zawijania (Protip: dodanie symbolu na początku zawiniętej linii)
opt.showbreak = "↪ " -- Znak wyświetlany na vzawiniętej części wiersza

-- ===== CORE OPTIONS =====
-- ═══════════════════════════════════════════════════════════════════════════

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

-- Persistent Undo: Historia zmian zapisywana w plikach (nawet po restarcie)
-- ═══════════════════════════════════════════════════════════════════════════

local undo_path = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_path) == 0 then
	vim.fn.mkdir(undo_path, "p")
end

vim.opt.undofile = true -- Włącz zapisywanie historii do pliku
vim.opt.undodir = undo_path -- Miejsce zapisu historii
vim.opt.undolevels = 10000 -- Maksymalna liczba cofnięć
vim.opt.undoreload = 10000 -- Liczba linii do zapisu przy przeładowaniu

-- Swap/Backup: Wyłącz, bo masz Persistent Undo i Git
vim.opt.swapfile = false -- Brak plików .swp
vim.opt.backup = false -- Brak plików ~
vim.opt.writebackup = false -- Brak kopii przy zapisie

-- ===== SEARCH =====
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- ===== LEADERS =====
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

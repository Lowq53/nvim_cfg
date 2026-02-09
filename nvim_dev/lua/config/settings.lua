-- c:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/lua/config/settings.lua
local opt = vim.opt

-- Force UTF-8 encoding and Unix line endings
-- ═══════════════════════════════════════════════════════════════════════════
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix" -- Fixes ^M issues

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


-- ===== Tresitter =====
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

-- need to check lualine evil_lualine is deleting by transparent backgorund in nvim dev
-- Wymuszenie przezroczystości na samym końcu ładowania
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy", -- Czeka, aż wszystkie pluginy się załadują
	callback = function()
		require("tokyonight").setup({ transparent = true })
		vim.cmd("colorscheme tokyonight")

		-- Dodatkowe "ubezpieczenie" - czyści tło ręcznie, gdyby plugin zawiódł
		local groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "NvimTreeNormal" }
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
})
-- === NUMBERS ===
vim.api.nvim_set_hl(0, "LineNr", { fg = "#d65a31", -- czerwono-pomarańczowy
})

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#ff8c42", -- jaśniejszy pomarańcz bold = false,
})

vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ff8c42",
  bold = false,
})

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff4500", -- mocny czerwony/orange
  bold = true,
})

-- === COMMENTS ===
vim.api.nvim_set_hl(0, "Comment", { fg = "#e5c07b", -- blady pomarańczowo-żółty
  italic = true,
})

-- opcjonalnie: Treesitter
vim.api.nvim_set_hl(0, "@comment", { fg = "#e5c07b",
  italic = true,
})

-- bundle 2026-10-05 23:53 from C:\Users\LOWq_53\AppData\Local\nvim

package.preload["commands"] = function(...)

end

package.preload["keymaps"] = function(...)
-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\init.lua
--
local k = vim.keymap.set
-- Wyjście z insert mode bez sięgania do Esc
k('i', 'jk', '<Esc>')
-- Nawigacja między oknami (Splits) jednym skrótem
k('n', '<C-h>', '<C-w>h')
k('n', '<C-j>', '<C-w>j')
k('n', '<C-k>', '<C-w>k')
k('n', '<C-l>', '<C-w>l')
-- Szybkie czyszczenie podświetlenia wyszukiwania
k('n', '<leader>nh', ':nohlsearch<CR>')
-- Centrowanie ekranu przy skokach (pół strony / wyszukiwanie)
k('n', '<C-d>', '<C-d>zz')
k('n', '<C-u>', '<C-u>zz')
k('n', 'n', 'nzzzv')
k('n', 'N', 'Nzzzv')

end

package.preload["layout"] = function(...)
-- 1. Definiujemy tabelę grup, które mają być przezroczyste
local transparent_groups = {
    "Normal",          -- Tło głównego okna
    "NormalNC",        -- Tło okien nieaktywnych
    "LineNr",          -- Numery linii
    "Folded",          -- Zwinięty kod
    "NonText",         -- Znaki specjalne (np. tyldy na końcu pliku)
    "SpecialKey",      -- Specjalne klawisze
    "VertSplit",       -- Pionowe linie podziału okien
    "SignColumn",      -- Kolumna po lewej (na błędy/git)
    "EndOfBuffer",     -- Tyldy na dole ekranu
    "StatusLine",      -- Pasek statusu
    "StatusLineNC",    -- Pasek statusu nieaktywnego okna
}

-- 2. Funkcja aplikująca przezroczystość
local function apply_transparency()
    for _, group in ipairs(transparent_groups) do
        -- bg = "NONE" mówi Neovimowi, żeby nie rysował tła
        -- ctermbg = "NONE" zapewnia wsparcie dla terminali 256-kolorowych
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
end

-- 3. Uruchom od razu
apply_transparency()

-- 4. PROTIP: Autokomenda (Senior Move)
-- Musisz to dodać, bo załadowanie jakiegokolwiek motywu (nawet wbudowanego)
-- nadpisze Twoje ustawienia. Ta komenda pilnuje, żeby zawsze było przezroczyście.
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_transparency,
})

end

package.preload["settings"] = function(...)
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

end

--- ~/.config/nvim/init.lua
-- only require here pls
-- relative numbers

-- PWSH
-- ... inne ustawienia Vima (vim.opt)
-- Załaduj konfigurację LazyVim z osobnego pliku

require('settings')
require('layout')
require('keymaps')
require('commands')
-- require("config.keymaps")
--require("config.terminal")
--require("config.lazy")
-- require("config.ui2")()
--  setting up own colorcheme
-- vim.cmd.colorscheme("tokyonight")
-- vim.schedule(function()
--	_G.set_transparency()
--	_G.set_custom_syntax_colors()
-- end)

-- Ustawienia dla Pythona
vim.opt_local.expandtab = true   -- Zamień tabulatory na spacje
vim.opt_local.shiftwidth = 4     -- Wcięcie na 4 spacje
vim.opt_local.tabstop = 4        -- Tabulator zajmuje 4 znaki
vim.opt_local.softtabstop = 4    -- Zachowanie Backspace przy 4 spacjach

-- Opcjonalnie: Linia pomocnicza na 88 znaku (standard Black)
vim.opt_local.colorcolumn = "88"

-- Keymapa tylko dla Pythona: Uruchom aktualny plik
vim.keymap.set('n', '<leader>rp', ':!python %<CR>', { buffer = true, desc = "Run Python file" })

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

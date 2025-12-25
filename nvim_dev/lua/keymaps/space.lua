-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\keymaps\space.lua
-- Kopiuje cały bufor do rejestru systemowego (+)
vim.keymap.set('n', '<space>y', ':%y+<CR>', { desc = 'Kopiuj cały bufor do systemowego schowka' })

-- Kopiuje pełną ścieżkę do bieżącego pliku do schowka systemowego (+)
vim.keymap.set('n', '<space>p', function()
  local path = vim.fn.expand('%:p') -- Pobiera pełną ścieżkę (absolute path)
  vim.fn.setreg('+', path)          -- Ustawia rejestr systemowy
  print('Skopiowano ścieżkę: ' .. path) -- Opcjonalne potwierdzenie w linii komend
end, { desc = 'Kopiuj pełną ścieżkę pliku' })

-- [['''
-- %	Relatywna ścieżka (np. lua/plugins/init.lua)
-- %:p	Pełna (absolutna) ścieżka (to, o co prosiłeś)
-- %:t	Tylko nazwa pliku (tail) (np. init.lua)
-- %:h	Ścieżka do folderu zawierającego plik (head)
--]]
--Wy konuje aktualny plik (source)
vim.keymap.set('n', '<space>x', '<cmd>source %<CR>', { desc = 'Source current file' })

-- DODATKOWO: Wykonuje tylko zaznaczony fragment (Visual Mode)
vim.keymap.set('v', '<space>x', ':source<CR>', { desc = 'Source selection' })

-- printing :messages
vim.keymap.set('n', '<space>m', '<cmd>:messages<CR>', { desc = ':messages' })

--  trybie normalnym: zaznacz cały bufor i przejdź do visual mode
vim.keymap.set('n', '<space>sa', 'ggVG', {
    desc = 'Select All (zaznacz cały tekst w buforze)',
    noremap = true,
    silent = true
})
-- vim.api.nvim_create_user_command('n', )

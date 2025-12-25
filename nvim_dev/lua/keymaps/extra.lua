-- Faza Konfiguracji: Masowa zamiana zaznaczonego tekstu
vim.keymap.set('v', '<leader>sr', function()
    -- Pobierz tekst z ostatniego zaznaczenia wizualnego
    -- Wykorzystujemy "gv" aby upewnić się, że pobieramy właściwy zakres
    vim.cmd('normal! "sy') -- Kopiuje zaznaczenie do rejestru 's'
    local search_term = vim.fn.getreg('s')
    
    -- Przygotuj komendę :s/.../ w linii komend bez jej zatwierdzania
    -- feedkeys pozwala na interaktywne dokończenie komendy
    local cmd = string.format(":'<,'>s/%s/", vim.fn.escape(search_term, '/\\'))
    vim.api.nvim_feedkeys(cmd, 'n', false)
end, { desc = 'Substitute: Zaznaczony tekst' })

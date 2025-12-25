
-- Senior Quickfix Navigation
local map = vim.keymap.set

-- Nawigacja bez otwierania okna listy
map('n', 'q]', '<cmd>cnext<cr>zz', { desc = 'Quickfix: Next' })
map('n', 'q[', '<cmd>cprev<cr>zz', { desc = 'Quickfix: Previous' })

-- Toggle okna Quickfix (używając funkcji Lua dla inteligencji)
map('n', '<leader>qo', function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then qf_exists = true end
    end
    if qf_exists the/kdjfksajf;n
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = 'Quickfix: Toggle Window' })

-- Bonus: Czyszczenie listy
map('n', '<leader>qc', '<cmd>cexpr []<cr>', { desc = 'Quickfix: Clear List' })

-- Skakanie po historiach list (Older / Newer)
map('n', '<leader>qo', '<cmd>colder<cr>', { desc = 'Quickfix: Poprzednia lista (History)' })
map('n', '<leader>qn', '<cmd>cnewer<cr>', { desc = 'Quickfix: Następna lista (History)' })

-- Bonus: Wyświetl wszystkie dostępne listy w historii
map('n', '<leader>qh', function()
    -- Ta komenda pokaże w linii komend indeksy i rozmiary list w historii
    vim.cmd('chistory')
end, { desc = 'Quickfix: Pokaż historię list' })

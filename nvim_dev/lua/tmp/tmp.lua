vim.opt.updatetime = 5000 -- czas w milisekunda dla atuozapisu cursor hold po tym czasie mozna robic auto-save


-- messages to new buffer
vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    
    -- Tworzymy nowy bufor bezpośrednio (bez przełączania okna od razu)
    local buf = vim.api.nvim_create_buf(false, true) -- listed: false, scratch: true
    
    -- Rozbijamy tekst i wstawiamy do bufora
    local lines = vim.split(messages, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Otwieramy bufor w nowym oknie (np. dolny split o wysokości 10 linii)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Opcjonalne: Ustawienie kursora na samym dole, by widzieć najnowsze logi
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
end, { desc = 'Messages to scratch buffer' })


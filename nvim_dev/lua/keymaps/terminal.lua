-- Mapowanie <space>t do otwierania terminala po lewej stronie
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>vsplit | term pwsh <CR>', {desc = ':term pwsh',
noremap = true, silent = true })

-- Automatyczne wyrównanie okien po otwarciu terminala
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    -- Ustawienia dla terminala
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    
    -- Wyrównanie rozmiaru okien (terminal zajmuje 30% szerokości)
    vim.cmd('wincmd =')
    vim.cmd('vertical resize 30')
    
    -- Przejście do trybu wstawiania w terminalu
    vim.cmd('startinsert')
  end
})

-- Opcjonalnie: Mapowanie ESC do wyjścia z trybu terminala
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = truE })

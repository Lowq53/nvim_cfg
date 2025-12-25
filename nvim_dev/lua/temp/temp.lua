vim.keymap.set('n', '<leader>tp', function()
    vim.cmd('vsplit')
    vim.cmd('term pwsh')
    -- Opóźnienie wysłania klawiszy, aby terminal zdążył się zainicjować
    vim.schedule(function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<C-\><C-n><C-w>=]], true, false, true), 'n', false)
    end)
end, { desc = "Open pwsh in vsplit and equalize" })

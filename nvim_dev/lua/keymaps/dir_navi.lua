vim.api.nvim_create_user_command('Ndev', function()
    vim.cmd('lcd C:/Users/LOWq_53/AppData/Local/nvim_dev')
    print("Katalog zmieniony na nvim_dev (lokalnie dla okna)")
end, { desc = 'Zmień katalog na nvim_dev' })
vim.api.nvim_create_user_command('Dc', function()
    vim.cmd('lcd C:/code_data')
    print("Katalog zmieniony na nvim_dev (lokalnie dla okna)")
end, { desc = 'Zmień katalog na nvim_dev' })


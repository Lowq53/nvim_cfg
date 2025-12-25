-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/lua/keymaps/dir_navi.lua

vim.api.nvim_create_user_command('Nvc', function()
    vim.cmd('cd C:/Users/LOWq_53/AppData/Local/nvim_cfg')
    print("Katalog zmieniony na nvim_dev (lokalnie dla okna)")
end, { desc = 'Zmień katalog na nvim_dev' })

vim.api.nvim_create_user_command('Ndev', function()
    vim.cmd('lcd C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev | pwd')
    print("Katalog zmieniony na nvim_dev (lokalnie dla okna)")
end, { desc = 'Zmień katalog na nvim_dev' })

vim.api.nvim_create_user_command('Dc', function()
    vim.cmd('lcd C:/code_data')
    print("Katalog zmieniony na code_data (lokalnie dla okna)")
end, { desc = 'Zmień katalog na code_data' })

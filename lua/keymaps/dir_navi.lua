-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/lua/keymaps/dir_navi.lua
local vks = vim.keymap.set

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

-- Kopiowanie pełnej ścieżki do schowka
vks('n', '<leader>pa', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { desc = 'Copy full path to clipboard' })
-- Otwieranie pliku ze schowka
vks('n', '<leader>po', function()
  local clipboard_content = vim.fn.getreg('+')
  if clipboard_content and clipboard_content ~= '' then
    vim.cmd('edit ' .. vim.fn.fnameescape(clipboard_content))
  else
    print('Clipboard is empty')
  end
end, { desc = 'Open file from clipboard' })

-- Dodatkowe przydatne vksowania:
vks('n', '<leader>pr', function()
  local path = vim.fn.expand('%:.') -- Relatywna ścieżka
  vim.fn.setreg('+', path)
  print('Copied relative path: ' .. path)
end, { desc = 'Copy relative path to clipboard' })

vks('n', '<leader>pf', function()
  local filename = vim.fn.expand('%:t') -- Tylko nazwa pliku
  vim.fn.setreg('+', filename)
  print('Copied filename: ' .. filename)
end, { desc = 'Copy filename to clipboard' })

vks('n', '<leader>pd', function()
  local dir = vim.fn.expand('%:p:h') -- Katalog pliku
  vim.fn.setreg('+', dir)
  print('Copied directory: ' .. dir)
end, { desc = 'Copy directory to clipboard' })

vks("n", "<leader>pn", ":set relativenumber!<CR>")

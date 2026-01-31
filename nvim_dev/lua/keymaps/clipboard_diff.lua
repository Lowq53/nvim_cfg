-- Szybkie porównanie obecnego bufora z innym wybranym
vim.keymap.set('n', '<leader>bd', function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.ui.input({ prompt = 'Numer bufora do porównania: ' }, function(input)
    if input then
      vim.cmd('vsplit | b ' .. input)
      vim.cmd('windo diffthis')
    end
  end)
end, { desc = "Diff z wybranym buforem" })


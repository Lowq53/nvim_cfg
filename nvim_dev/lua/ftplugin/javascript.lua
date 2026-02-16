-- Ustawienia dla JS/TS
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

-- Dodatkowe: ukrywanie folderu node_modules w wyszukiwaniu lokalnym
vim.opt_local.suffixesadd:append({'.js', '.ts', '.jsx', '.tsx'})

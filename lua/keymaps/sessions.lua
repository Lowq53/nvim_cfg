local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

vks("n", "<space>so", "<cmd>Sl<cr>", { desc = "Otwórz listę sesji" })

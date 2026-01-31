local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

vks("n", "<space>sc", "<cmd>Smgr current<cr>", { desc = "Otwórz current" })
vks("n", "<space>sw", "<cmd>Smgr save<cr>", { desc = "Otwórz listę sesji" })
vks("n", "<space>so", "<cmd>Smgr list<cr>", { desc = "Otwórz listę sesji" })

local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

vks("n", "<space>sc", "<cmd>Smgr current<cr>", { desc = "Smgr current." })
vks("n", "<space>sw", "<cmd>Smgr save<cr>", { desc = "Smgr save." })
vks("n", "<space>so", "<cmd>Smgr list<cr>", { desc = "Smgr session list." })

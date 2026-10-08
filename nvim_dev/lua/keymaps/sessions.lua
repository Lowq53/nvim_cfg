local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

vks("n", "<space>sc", "<cmd>Smgr current<cr>", { desc = "Smgr current.", silent = true })
vks("n", "<space>sw", "<cmd>Smgr save<cr>", { desc = "Smgr save.", silent = true })
vks("n", "<space>so", "<cmd>Smgr list<cr>", { desc = "Smgsession list.", silent = true })
vks("n", "<leader>o", "<cmd>Smgr list<cr>", { desc = "Smgr session list.", silent = true })
vks("n", "<space>sr", "<cmd>Smgr rename<cr>", { desc = "Smgr session rename.", silent = true })nvim

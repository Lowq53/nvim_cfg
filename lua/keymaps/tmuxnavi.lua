local vks = vim.keymap.set

-- Tmux navigator keys (Jeśli używasz nvim-tmux-navigation, te mapowania mogą kolidować z powyższymi C-h/l)
vks("n", "<C-h>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLeft() end, { silent = true })
vks("n", "<C-j>", function() require("nvim-tmux-navigation").NvimTmuxNavigateDown() end, { silent = true })
vks("n", "<C-k>", function() require("nvim-tmux-navigation").NvimTmuxNavigateUp() end, { silent = true })
vks("n", "<C-l>", function() require("nvim-tmux-navigation").NvimTmuxNavigateRight() end, { silent = true })
vks("n", "<C-\\>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLastActive() end, { silent = true })

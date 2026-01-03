-- # those should go to /keymaps - to correct - area
--
-- text manipulation i insert mode

-- Move cursor in Insert Mode
-- vim.keymap.set("i", "<S-h>", "<Left>", { desc = "Move left" })
-- vim.keymap.set("i", "<S-l>", "<Right>", { desc = "Move right" })
-- vim.keymap.set("i", "<S-k>", "<Up>", { desc = "Move up" })
-- vim.keymap.set("i", "<S-j>", "<Down>", { desc = "Move down" })

vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

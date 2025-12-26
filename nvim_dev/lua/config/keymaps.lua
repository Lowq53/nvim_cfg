-- # those should go to /keymaps - to correct - area
--
-- text manipulation i insert mode

-- Move cursor in Insert Mode
vim.keymap.set("i", "<S-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<S-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<S-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<S-j>", "<Down>", { desc = "Move down" })

vim.keymap.set("i", "<A-k>", "<Es\gcc:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

-- Toggle Quickfix list (Senior approach)
local function toggle_qf()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1
			qf_exists = true
		end
	end
	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end
vim.keymap.set('n', '<space>q', toggle_qf, { desc = "Toggle Quickfix" })





-- Senior Quickfix Navigation
local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
-- Nawigacja bez otwierania okna listy
map("n", "q]", "<cmd>cnext<cr>zz", { desc = "Quickfix: Next" })
map("n", "q[", "<cmd>cprev<cr>zz", { desc = "Quickfix: Previous" })

-- Toggle okna Quickfix (używając funkcji Lua dla inteligencji)
map("n", "<leader>qo", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Quickfix: Toggle Window" })

-- vim.keymap.set('t', '<Esc>', [[<C-\><C-n]], { desc = 'Exit terminal mode'})
vim.keymap.set("n", "<C-q>j", ":cnext<CR>", { desc = "Następny quickfix" })
vim.keymap.set("n", "<C-q>k", ":cprev<CR>", { desc = "Poprzedni quickfix" })
vim.keymap.set("n", "<C-q>h", ":colder<CR>", { desc = "Starsza lista quickfix" })
vim.keymap.set("n", "<C-q>l", ":cnewer<CR>", { desc = "Nowsza lista quickfix" })

-- Bonus: Czyszczenie listy
map("n", "<leader>qc", "<cmd>cexpr []<cr>", { desc = "Quickfix: Clear List" })

-- Skakanie po historiach list (Older / Newer)
map("n", "<leader>qo", "<cmd>colder<cr>", { desc = "Quickfix: Poprzednia lista (History)" })
map("n", "<leader>qn", "<cmd>cnewer<cr>", { desc = "Quickfix: Następna lista (History)" })

-- Bonus: Wyświetl wszystkie dostępne listy w historii
map("n", "<leader>qh", function()
	-- Ta komenda pokaże w linii komend indeksy i rozmiary list w historii
	vim.cmd("chistory")
end, { desc = "Quickfix: Pokaż historię list" })

-- aliasy dla quicklist
-- :co    " Alias for :copen (open)
-- :ccl   " Alias for :cclose (close)
-- :cn    " Jump to next item
-- :cp    " Jump to previous item

cmd("Qo", "copen", { desc = "Alias for copen" })
cmd("Qc", "cclose", { desc = "Alias for cclose" })
cmd("Qn", "cnext", { desc = "Next quickfix item" })
cmd("Qp", "cprev", { desc = "Previous quickfix item" })

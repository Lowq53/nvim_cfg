-- Senior Quickfix Navigation
local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
-- Nawigacja bez otwierania okna listy
vks("n", "q]", "<cmd>cnext<cr>zz", { desc = "Quickfix: Next" })
vks("n", "q[", "<cmd>cprev<cr>zz", { desc = "Quickfix: Previous" })
-- Następny/poprzedni PLIK wewnątrz listy Quickfix
vim.keymap.set("n", "]Q", "<cmd>cnf<CR>", opts)
vim.keymap.set("n", "[Q", "<cmd>cpf<CR>", opts)

-- Przeskok do pierwszego i ostatniego wpisu całej listy
--vim.keymap.set("n", "<leader>qf", "<cmd>cfirst<CR>", opts)
--vim.keymap.set("n", "<leader>ql", "<cmd>clast<CR>", opts)

-- Toggle okna Quickfix (używając funkcji Lua dla inteligencji)
vks("n", "<C-q>o", function()
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
vks("n", "<leader>qc", "<cmd>cexpr []<cr>", { desc = "Quickfix: Clear List" })

-- Skakanie po historiach list (Older / Newer)
vks("n", "<leader>qo", "<cmd>colder<cr>", { desc = "Quickfix: Poprzednia lista (History)" })
vks("n", "<leader>qn", "<cmd>cnewer<cr>", { desc = "Quickfix: Następna lista (History)" })

-- Bonus: Wyświetl wszystkie dostępne listy w historii
vks("n", "<leader>qh", function()
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

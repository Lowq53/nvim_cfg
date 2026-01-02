-- Minimalny setup integrujący natywny Quickfix z Telescope
-- ────────────────────────────────────────────────────────────────────────
local Q = {}

Q.setup_quickfix_mappings = function()
	vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open Quickfix" })
	vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close Quickfix" })
	vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous QF Item" })
	vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next QF Item" })
end

Q.search_and_qf = function()
	require("telescope.builtin").live_grep({
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		on_complete = {
			function(picker)
				-- Automatyczne wysyłanie wyników do Quickfix przy specyficznych akcjach
				vim.keymap.set("i", "<C-q>", require("telescope.actions").send_to_qf, { buffer = picker.bufnr })
			end,
		},
	})
end

return Q

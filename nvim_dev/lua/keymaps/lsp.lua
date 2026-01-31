vim.keymap.set({ "n", "v" }, "<leader>ff", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file" })

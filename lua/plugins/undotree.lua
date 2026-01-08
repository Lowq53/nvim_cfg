return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>pu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
			{ "<leader>p[", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
		},
		init = function()
			-- focus na toggle
			vim.g.undotree_SetFocusWhenToggle = 1
			-- split pionowy zamiast poziomego
			vim.g.undotree_TreeVertSplit = 1
			-- diff opcje
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_DiffAutoRefresh = 0
			-- pokaż numer node i gałąź
			vim.g.undotree_ShowTextNodeState = 1
			-- automatyczny scroll do ostatniego undo node
			vim.g.undotree_HighlightChangedText = "DiffAdd"
			-- kolory dla zmienionych tekstów (pro UX)
		end,
	},
}

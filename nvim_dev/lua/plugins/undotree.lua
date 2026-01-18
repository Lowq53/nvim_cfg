return {
	--- @plugin: mbbill/undotree
	--- @description: Wizualizacja drzewa operacji undo. Pozwala na nawigację
	--- po alternatywnych gałęziach zmian, które normalnie są tracone po wykonaniu
	--- nowej akcji po "cofnięciu" (undo).
	--- @see: https://github.com/mbbill/undotree
	{
		"mbbill/undotree",
		-- Skróty klawiszowe ładowane leniwie (lazy loading)
		keys = {
			{ "<leader>pu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
			{ "<leader>p[", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
		},
		init = function()
			-- Interfejs i UX:
			-- Automatyczne przeniesienie focusu na okno drzewa po otwarciu
			vim.g.undotree_SetFocusWhenToggle = 1
			-- Okno drzewa pojawia się w pionowym podziale (vertical split)
			vim.g.undotree_TreeVertSplit = 1
			-- Wydajność: nie otwieraj panelu diff automatycznie (oszczędza miejsce)
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_DiffAutoRefresh = 0
			-- Informacyjność: pokaż stan węzła (node state) i numer gałęzi
			vim.g.undotree_ShowTextNodeState = 1
			-- UX: Podświetlanie zmienionego tekstu przy użyciu grupy DiffAdd
			vim.g.undotree_HighlightChangedText = "DiffAdd"
		end,
	},
}

return {
{
		"mbbill/undotree",
		keys = {
			{ "<leader>pu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
			{ "<leader>p[", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
		},
		init = function()
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_TreeVertSplit = 1
		end,
	},
}

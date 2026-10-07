return {
  -- Oil.nvim
  --https://github.com/stevearc/oil.nvim
  {
    'stevearc/oil.nvim',
    lazy = false,
    config = function()
      local vks = vim.keymap.set
      require("oil").setup({
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        view_options = {
          show_hidden = true,
          default_file_explorer = true,
          delete_to_trash = true, -- poprawka: trash nie trast
        },
      })
      vks("n", "-", "<CMD>Oil<CR>", { desc = "Oil file manager" })
    end,
  },
  -- nvim-tree -- file manager
  -- https://github.com/nvim-tree/nvim-tree.lua
  { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  -- UndoTree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>pu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
    },
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeVertSplit = 1
    end,
  },
}

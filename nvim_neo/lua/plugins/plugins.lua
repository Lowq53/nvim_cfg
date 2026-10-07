-- lua/plugins/ui.lua
return {
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>pu", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" }
    }
  },
  { import = "plugins.nvimtree" },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  -- http://github.com/iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

}

return{
  -- Git integration (fugitive)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
    },
  },
  {
  'sindrets/diffview.nvim'
  },

  -- Git conflict resolver
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require('git-conflict').setup({
        default_mappings = true,  -- <leader>co, <leader>ct, <leader>cb, <leader>ca
        default_commands = true,  -- GitConflictChooseOurs, GitConflictChooseTheirs
      })
    end,
    keys = {
      { "<leader>co", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
      { "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
      { "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
      { "<leader>c0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
    },
  },

  -- Enhanced diff view
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diff view open" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diff view close" },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup()
    end,
  },
}

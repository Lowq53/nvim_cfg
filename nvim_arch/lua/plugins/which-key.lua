return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    
    -- Setup which-key
    wk.setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
    })
    
    -- [[=====================================================
    -- Plugin management keybinds
    -- Plugins group
    wk.add({
      { "<leader>p", group = "[P]lugins" },
      { "<leader>pe", "<cmd>Explore<cr>", desc = "Explore Lazy" },


      { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install plugins" },
      { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update plugins" },
      { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync plugins" },
      { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean plugins" },
    })
    
    -- Git group
    wk.add({
      { "<leader>g", group = "[G]it" },
      { "<leader>gs", "<cmd>Git status<cr>", desc = "Git status" },
      { "<leader>ga", "<cmd>Git add .<cr>", desc = "Git add all" },
    })
    
    -- File group (commented out as you had it)
    -- wk.add({
    --   { "<leader>f", group = "Files" },
    --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    --   { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    -- })
    -- [[=====================================================
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

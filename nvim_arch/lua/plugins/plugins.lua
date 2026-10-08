-- ~/.config/nvim/lua/plugins.lua

return {
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "nvim-lua/plenary.nvim" },
    { "tpope/vim-fugitive",
        keys = {  -- Keymaps load with the plugin
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git log<CR>", desc = "Git Log" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git Diff" },
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git Blame" },
    },
},
    
  { "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
      -- Essential keymaps (local to avoid conflicts)
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<leader>3", ui.toggle_quick_menu)
      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
    end,
  },
  { "mbbill/undotree",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" }
    },
  },
  -- plugins save test    
  -- Plugin nvim-tree
  { "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Załaduj konfigurację dla nvim-tree z osobnego pliku
      require("plugins.nvimtree")
    end,
  },

  -- nvim / tmux navigation
{ "alexghergh/nvim-tmux-navigation",
  lazy = false,
  config = function()
    require("nvim-tmux-navigation").setup {
      -- tmux zoom wyłącza nawigację 
      disable_when_zoomed = true
    }
  end,
  keys = {
  { "<C-h>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLeft() end },
  { "<C-j>", function() require("nvim-tmux-navigation").NvimTmuxNavigateDown() end },
  { "<C-k>", function() require("nvim-tmux-navigation").NvimTmuxNavigateUp() end },
  { "<C-l>", function() require("nvim-tmux-navigation").NvimTmuxNavigateRight() end },
  { "<C-\\>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLastActive() end },
  },
},

}

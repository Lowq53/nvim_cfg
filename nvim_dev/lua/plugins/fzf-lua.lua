return {
  {
    "ibhagwan/fzf-lua",
    -- Poprawiona nazwa ikon
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        -- Tutaj możesz dodać styl okna, np. 'telescope'
        winopts = {
          height = 0.85,
          width = 0.80,
          preview = { layout = 'vertical' }
        }
      })
    end,
    -- Skróty klawiszowe, żeby nie wpisać ręcznie require
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Fzf Files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Fzf Grep" },
    },
  },
  }

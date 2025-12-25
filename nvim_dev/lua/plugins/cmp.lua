return {
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    -- build = "make install_jsregexp", -- dla Windows usuń tę linię
    dependencies = {
      "rafamadriz/friendly-snippets", -- gotowe snippety
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
-- fast engine for autocomplet written in Rust
    "saghen/blink.cmp",
    version = "1.*",
    event = 'VimEnter',
    dependencies = {
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs",
"rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "default",
      },

      snippets = {
        preset = "luasnip", -- MAŁE LITERY
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
     fuzzy = { implementation = 'lua' },
  },

}


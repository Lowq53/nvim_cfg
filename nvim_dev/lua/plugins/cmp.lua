return {
  -- https://github.com/rafamadriz/friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    -- build = "make install_jsregexp", -- dla Windows usu‰ t© lini©
    dependencies = {
      "rafamadriz/friendly-snippets", -- gotowe snippety
    },
    config = function()
      local ls = require("luasnip")

      -- vscode (friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- own snippets
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })

      -- keymaps
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },

  {
    -- fast engine for autocomplete written in Rust
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
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
        preset = "luasnip", -- MAùE LITERY
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = {
        implementation = "lua",
      },
    },
  },
}


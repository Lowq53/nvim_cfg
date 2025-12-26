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
      require("luasnip.loaders.from_lua").load({paths = vim.fn.stdpath("config") .. "/lua/snippets/"})
      local ls = require("luasnip")
      vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, {silent = true})
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
      fuzzy = { implementation = 'lua' },
    },
  },
}



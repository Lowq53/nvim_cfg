return {
  -- 1. MASON - instalator LSP/formatters/linters
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  -- 2. MASON-LSPCONFIG - mostek między Mason a LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",      -- Lua
        "pyright",     -- Python
        "ts_ls",       -- TypeScript/JavaScript
        "html",        -- HTML
        "cssls",       -- CSS
      },
      automatic_enable = true, -- AUTO włącza zainstalowane LSP (v2.0)
    },
  },

  "neovim/nvim-lspconfig",

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "prettier",
        "black",
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  "numToStr/Comment.nvim",
  "stevearc/conform.nvim",
  -- "Darazaki/guess-indent.nvim",
}

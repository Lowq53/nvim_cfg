return {
  "neovim/nvim-lspconfig",

  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "prettier",
      },
    },
  },

  "folke/lazydev.nvim",
  "numToStr/Comment.nvim",
  "stevearc/conform.nvim",
  "Darazaki/guess-indent.nvim",
}

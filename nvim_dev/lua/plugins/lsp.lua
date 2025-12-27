return {
  -- ======================== LSP & MASON ========================
  -- 真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "j-hui/fidget.nvim",
    },
    config = function()
      require("mason").setup()
      local mason_lsp = require("mason-lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gR", vim.lsp.buf.references, "References")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        pyright = {},
        ts_ls = {},
        html = {},
        cssls = {},
        powershell_es = {},
        vimls = {},
        bashls = {},
      }

      -- Mason zainstaluje serwery
      mason_lsp.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      for server, opts in pairs(servers) do
        opts.capabilities = capabilities
        vim.lsp.config[server] = opts
        vim.lsp.enable(server)
      end
    end,
  },

  -- ======================== TREESITTER ========================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "javascript", "typescript", "markdown", "vimdoc" },
      highlight = { enable = true },
    },
  },

  -- ======================== FORMAT & TOOLS ========================
  { "stevearc/conform.nvim", opts = { format_on_save = { lsp_format = "fallback" } } },
  { "folke/lazydev.nvim",    ft = "lua",                                             opts = {} },
}

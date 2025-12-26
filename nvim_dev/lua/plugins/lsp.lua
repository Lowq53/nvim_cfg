return {
  -- ======================== LSP & MASON ========================
  
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
    local mason_lsp = require("mason-lspconfig")

    -- capabilities z blink.cmp (LuaSnip + completion)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- keymapy po attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, {
            buffer = event.buf,
            desc = "LSP: " .. desc,
          })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gR", vim.lsp.buf.references, "References")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
      end,
    })

    -- definicje serwer¢w
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },

      pyright = {},
      ts_ls = {},
      html = {},
      cssls = {},
      powershell_es = {},
    }

    -- Mason: instalacja
    mason_lsp.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- NOWE API: vim.lsp.config
    for server, opts in pairs(servers) do
      vim.lsp.config(server, vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, opts))
    end
  end,
},



  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },

  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- ======================== TREESITTER ========================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c", "lua", "python", "javascript", "typescript",
        "html", "css", "json", "yaml", "markdown",
        "vim", "vimdoc", "query",
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
  },

  -- ======================== AUTOCOMPLETION ========================
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "prefer_rust" },
      signature = { enabled = true },
    },
  },

  -- ======================== FORMAT ========================
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
        formatters_by_ft = {
          lua = { "stylua" }, -- senior-style formatter
        },
      },
    },
  },

  -- ======================== DEV TOOLS ========================
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,




    },
  },

}

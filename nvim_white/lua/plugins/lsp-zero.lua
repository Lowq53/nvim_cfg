-- Add this to your lazy.nvim plugin configuration
-- Usually in ~/.config/nvim/lua/plugins/lsp.lua or similar
return {
    -- lazydev configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the vim.uv word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
    },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- DODANE: źródło snippetów
        },
        mapping = cmp.mapping.preset.insert({
          -- Complete suggestions
          -- ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<CR>'] = cmp.mapping.confirm({select = true}),
          -- Navigate suggestions
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Next suggestion
          -- Confirm selection
          ['<C-Space>'] = cmp.mapping.complete(),           -- Complete suggestions
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Confirm with Ctrl+y
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm with Enter
          -- Scroll documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          -- WAŻNE: Tab handling dla snippetów
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
              fallback()
            else
            end
          end, { 'i', 's' }),
        }),
        snippet = {
          expand = function(args)
            -- vim.snippet.expand(args.body)
            luasnip.lsp_expand(args.body)
          end,
        },
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        
        -- Dodatkowe keybindy dla diagnostyk
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        vim.keymap.set('n', '<leader>b', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
      end
      
      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })
      
      require('mason-lspconfig').setup({
        ensure_installed = {
          'eslint',        -- ESLint for JavaScript/TypeScript linting
          'ts_ls',         -- TypeScript/JavaScript language server
          'lua_ls',        -- Lua language server (Sumneko)
          'rust_analyzer', -- Rust language server
          'pyright',       -- Python language server
          'bashls',        -- Bash Language Server
          --'beautysh',    -- Shell script linter
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          
          -- Custom handler dla lua_ls (z kickstart.nvim)
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                  -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                  -- diagnostics = { disable = { 'missing-fields' } },
                  diagnostics = {
                    globals = { 'vim' }, -- To naprawia błąd "undefined global vim"
                  },
                },
              },
            }
          end,
        }
      })
    end
  }
}

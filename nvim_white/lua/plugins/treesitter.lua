return {
    {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { 
            -- "help",
                   "python", "markdown", "markdown_inline", "lua", "vim", "vimdoc", "query" }, -- dodaj języki których potrzebujesz
      highlight = { enable = true, },
      indent = { enable = true, },
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    }
    })
  end,
},
{ 
  "nvim-treesitter/playground", 
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Explicit dependency,
        config = function()

        require "nvim-treesitter.configs".setup({
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
        },
    }       
    })
        end,
    }
}

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts

  lazy = false,
  config = function()
    local vks = vim.keymap.set
    require("oil").setup({
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      view_options = {
        show_hidden = true, -- pokaż ukryte pliki, np. .config, .gitignore
        default_file_explorer = true,
        show_hidden = true,
        delete_to_trast = true,
      },
    })

    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.

    -- keymps
    vks("n", "-", "<CMD>Oil<CR>", { desc = "Oil file manager" })
    -- Set up oil keymaps when oil buffer is opened
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.keymap.set("n", "q", function()
          require("oil").close()
        end, { buffer = true, desc = "Close oil (like Ctrl-C)" })
      end,
    })
  end,
}

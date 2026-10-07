return {
  {
    'Lowq53/nvim-session-manager',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'Ms', 'Mr' }, -- Load the plugin only when its commands are run

    config = function()
      require('session_manager').setup({
        -- Optional: Change the base directory where sessions are stored
        -- By default, this is ~/.local/share/nvim/sessions (Linux/macOS)
        -- or C:\Users\User\AppData\Local\nvim\sessions (Windows)
        base_dir = vim.fn.stdpath("data") .. '/sessions',
      })
    end,
    keys = {
      -- Example key mappings for quick saving/restoring the 'main' session
      { "<leader>sm", ":Ms main<CR>", mode = "n", desc = "Save Main Session" },
      { "<leader>rm", ":Mr main<CR>", mode = "n", desc = "Restore Main Session" },
    },
  },
}

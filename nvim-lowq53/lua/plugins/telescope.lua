return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    -- Konfiguracja Telescope (opcjonalna)
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          "^.git/",
          "^node_modules/",
          "^.venv/",
          "^build/",
          "^dist/",
          -- Ignoruj pliki
          "%.pyc$",          -- Pliki skompilowane Pythona
          "%.o$",            -- Obiekty C/C++
          "%.a$",            -- Biblioteki statyczne
          "%.swp$",          -- Pliki swap Vima
          "%.bak$",          -- Backupowe pliki
          "%.blend%.%d+$",   -- Pliki backup Blendra (np. `.blend1`, `.blend2`)
          "**/.rclone/*",    -- Ignoruj cache rclone
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })
    require('telescope').load_extension('ui-select')
  end,


  keys = {
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eymaps" },
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "[S]earch [F]iles" },
    { "<leader>ss", "<cmd>Telescope builtin<CR>", desc = "[S]earch [S]elect Telescope" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "[S]earch current [W]ord" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "[S]earch by [G]rep" },
    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", "<cmd>Telescope resume<CR>", desc = "[S]earch [R]esume" },
    { "<leader>so", "<cmd>Telescope oldfiles<CR>", desc = "[S]earch Recent Files" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Tele✨: Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Tele✨: Live grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Tele✨: Help tags" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Tele✨: Buffers" },
    {
      "<leader>fp",
      function()
        require('telescope.builtin').find_files({
          search_dirs = {
            "E:/Tools/BPY_Scripts/programming_do/",
            "C:/code_data/bash/nvim",
            "E:/Tools/BPY_Scripts/",
            "C:/Users/User/Documents",
            vim.fn.expand("%:h"),
            vim.fn.expand("~/projects"),
            vim.fn.getcwd(), -- bieżący katalog Neovima
            -- "/var/www",
            -- mozna dodac path do rcloan
          },
          hidden = true, -- pokazuj ukryte pliki (np. .gitignore)
        })
      end,
      desc = 'Tele:✨All'
    },

    {
      "<leader>fn",
      function()
        require('telescope.builtin').find_files({
          search_dirs = {
            "C:/Users/LOWq_53/AppData/Local/nvim/",
            "C:/Users/LOWq_53/AppData/Local/nvim-lowq53/",
            -- "C:/code_data/bash/nvim",
          },
          hidden = true, -- pokazuj ukryte pliki (np. .gitignore)
        })
      end,
      desc = 'Tele:✨ Nvim.lua'
    }
  }
}

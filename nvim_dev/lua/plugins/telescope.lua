return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      -- ═══════════════════════════════════════════════════════════════
      -- TELESCOPE SETUP
      -- ═══════════════════════════════════════════════════════════════
      telescope.setup({
        defaults = {
          -- Ignorowane pliki i foldery
          file_ignore_patterns = {
            "^.git/",
            "^node_modules/",
            "^.venv/",
            "^build/",
            "^dist/",
            "%.pyc$",
            "%.o$",
            "%.a$",
            "%.swp$",
            "%.bak$",
            "%.blend%.%d+$",
          },
          -- Mapowania nawigacyjne
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-h>"] = actions.preview_scrolling_up,
              ["<C-l>"] = actions.preview_scrolling_down,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      -- ═══════════════════════════════════════════════════════════════
      -- CORE NAVIGATION - podstawowe skróty
      -- ═══════════════════════════════════════════════════════════════
      vim.keymap.set("n", "sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "so.", builtin.oldfiles, { desc = "[S]earch [O]ld files" })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find buffers" })

      -- ═══════════════════════════════════════════════════════════════
      -- SEARCH HELPERS - pomoc w wyszukiwaniu
      -- ═══════════════════════════════════════════════════════════════
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

      -- ═══════════════════════════════════════════════════════════════
      -- NVIM CONFIG - przeszukiwanie konfiguracji Neovim
      -- ═══════════════════════════════════════════════════════════════
      -- Find files w config
      vim.keymap.set("n", "<leader>fc", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
          hidden = true,
        })
      end, { desc = "[F]ind in nvim [C]onfig" })

      -- Grep w config
      vim.keymap.set("n", "<leader>gc", function()
        builtin.live_grep({
          search_dirs = { vim.fn.stdpath("config") },
        })
      end, { desc = "[G]rep nvim [C]onfig" })

      -- ═══════════════════════════════════════════════════════════════
      -- PROJECT DIRECTORIES - twoje katalogi robocze
      -- ═══════════════════════════════════════════════════════════════
      -- Current working directory
      vim.keymap.set("n", "<leader>fy", function()
        builtin.find_files({ cwd = vim.fn.getcwd(), hidden = true })
      end, { desc = "[F]ind cwd" })

      -- Code data (Windows)
      vim.keymap.set("n", "<leader>fd", function()
        builtin.find_files({ cwd = "C:/code_data/", hidden = true })
      end, { desc = "[F]ind code_[D]ata" })

      -- Programming do
      vim.keymap.set("n", "<leader>fp", function()
        builtin.find_files({ cwd = "E:/Tools/BPY_Scripts/programming_do/", follow = true })
      end, { desc = "[F]ind [P]rogramming_do" })

      -- Aktualny folder pliku
      vim.keymap.set("n", "<leader>f/", function()
        builtin.find_files({ cwd = vim.fn.expand("%:h") })
      end, { desc = "[F]ind in current file dir" })

      -- ═══════════════════════════════════════════════════════════════
      -- GREP IN DIRECTORIES - grep w katalogach
      -- ═══════════════════════════════════════════════════════════════
      vim.keymap.set("n", "<leader>sb", function()
        builtin.live_grep({
          search_dirs = { "E:/Tools/BPY_Scripts/" },
        })
      end, { desc = "[S]earch in [B]PY scripts" })

      vim.keymap.set("n", "<leader>sc", function()
        builtin.live_grep({
          search_dirs = { "C:/code_data/" },
        })
      end, { desc = "[S]earch in [C]ode_data" })

      -- ═══════════════════════════════════════════════════════════════
      -- BUFFER & FUZZY SEARCH - wyszukiwanie w buforach
      -- ═══════════════════════════════════════════════════════════════
      -- Fuzzy search w aktualnym buforze
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 9,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzy search in buffer" })

      -- Grep tylko w otwartych plikach
      vim.keymap.set("n", "<leader>a", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "Grep in open files" })

      -- ═══════════════════════════════════════════════════════════════
      -- CUSTOM COMMANDS
      -- ═══════════════════════════════════════════════════════════════
      vim.api.nvim_create_user_command("BpyFiles", function()
        builtin.find_files({
          cwd = "E:/Tools/BPY_Scripts/",
          hidden = true,
        })
      end, {})

      -- ═══════════════════════════════════════════════════════════════
      -- DUPLICATE KEYMAPS (wykomentowane - użyj powyższych zamiast tego)
      -- ═══════════════════════════════════════════════════════════════
      -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Tele✨: Find files" })
      -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Tele✨: Live grep" })
      -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Tele✨: Help tags" })
      -- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Tele✨: Buffers" })
      -- vim.keymap.set("n", "<leader>fv", function()
      --   builtin.find_files({ cwd = "C:/code_data/bash/nvim", hidden = true })
      -- end, { desc = "/nvim" })
      -- vim.keymap.set("n", "<leader>sn", function()
      --   builtin.find_files({ cwd = vim.fn.stdpath("config") })
      -- end, { desc = "[S]earch [N]eovim files" })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}

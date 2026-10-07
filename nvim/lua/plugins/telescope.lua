return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
       extensions = {
  ["ui-select"] = require("telescope.themes").get_dropdown(),
},
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  telescope.setup({
          defaults = {
            file_ignore_pattern = {
              -- ignourue foldery
              "^.git/",
              "^node_modules/",
              "^.venv/",
              "^build/",
              "^dist/",
              -- Ignoruj pliki
              "%.pyc$",        -- Pliki skompilowane Pythona
              "%.o$",          -- Obiekty C/C++
              "%.a$",          -- Biblioteki statyczne
              "%.swp$",        -- Pliki swap Vima
              "%.bak$",        -- Backupowe pliki
              "%.blend%.%d+$", -- Pliki backup Blendra (np. `.blend1`, `.blend2`)
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

        -- ► Standardowe skróty
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "so.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- ► Dodatkowe skróty
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Tele✨: Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Tele✨: Live grep" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Tele✨: Help tags" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Tele✨: Buffers" })

        -- *** find_files
        -- Katalog code_datacwd = vim.fn.getcwd()
        vim.keymap.set("n", "<leader>fy", function()
          builtin.find_files({ cwd = vim.fn.getcwd(), hidden = true })
        end, { desc = "/code_data" })

        vim.keymap.set("n", "<leader>fc", function()
          builtin.find_files({ cwd = "C:/code_data/", hidden = true })
        end, { desc = "/code_data" })

        -- Katalog programming_do
        vim.keymap.set("n", "<leader>fd", function()
          builtin.find_files({ cwd = "E:/Tools/BPY_Scripts/programming_do/", follow = true })
        end, { desc = "/programming_do" })

        -- Znajdź pliki w katalogu pliku (przepisane na vim.keymap.set)
        vim.keymap.set("n", "<leader>f/", function()
          require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:h") })
        end, { desc = "ff/%:h(actual)" })

        --			-- Znajdź pliki w katalogu pliku (staru zais)
        --			vim.api.nvim_set_keymap("n", "<leader>cf",function()
        --			builtin.find_files({ cwd = vim.fn.expand("%:h") })<CR>',
        --				{ noremap = true, silent = true }
        --			)

        -- Znajdź pliki w ~/.config/nvim
        vim.keymap.set("n", "<leader>fv", function()
          builtin.find_files({ cwd = "C:/code_data/bash/nvim", hidden = true })
        end, { desc = "/nvim" })

        -- Komenda BpyFiles
        vim.api.nvim_create_user_command("BpyFiles", function()
          builtin.find_files({
            cwd = "E:/Tools/BPY_Scripts/", -- poprawiona ścieżka
            hidden = true,
          })
        end, {})

        -- Szukanie w aktualnym buforze (ładny dropdown)
        vim.keymap.set("n", "<leader>/", function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 9,
            previewer = false,
          }))
        end, { desc = "[/] Search in current buffer" })

        -- Szukanie tylko w otwartych plikach
        vim.keymap.set("n", "<leader>a", function()
          builtin.live_grep({
            gprep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end, { desc = "[S]earch [/] in Open Files" })

        -- Grep w wielu katalogach
        vim.keymap.set("n", "<leader>sb", function()
          builtin.live_grep({
            search_dirs = {
              "E:/Tools/BPY_Scripts/",
              vim.fn.expand("~") .. "/projects/",
            },
          })
        end, { desc = "/bpy_scripts" })

        vim.keymap.set("n", "<leader>sc", function()
          builtin.live_grep({
            search_dirs = {
              "C:/code_data/",
              vim.fn.expand("~") .. "/projects/",
            },
          })
        end, { desc = "/code_data" })


        -- Szukanie plików Neovim
        vim.keymap.set("n", "<leader>sn", function()
          builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
      end,
    },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}

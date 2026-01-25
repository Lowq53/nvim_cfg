
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},

		-- 🔑 JEDYNY trigger do łądowania telescope
		keys = function()
			-- Funkcja pomocnicza 'tb' (Telescope Builtin)
  		-- Opakowuje wywołanie w funkcję, aby lazy-loading działał poprawnie
  		local builtin = require("telescope.builtin")
  		local function tb(fn, opts)
  			return function()
  				builtin[fn](opts)
  			end
  		end
			return {
				-- CORE
				{ "ff", tb("find_files"), desc = "[S]earch [F]iles" },
				{ ".ff", tb("find_files"), desc = "[S]earch [F]iles" },
				{ ".gg", tb("live_grep"), desc = "[G]rep [F]iles" },

				-- PWD / CWD (Current Working Directory)
        { ".fy", tb("find_files", { cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":h"), hidden = true }), desc = "[F]iles .. (CWD)" },
        { ".gy", tb("live_grep",  { cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":h"), hidden = true }), desc = "[G]rep .. CWD" },
        { ".fc", tb("find_files", { cwd = vim.fn.getcwd(), hidden = true }), desc = "Find Files (CWD)" },
        { ".gc", tb("live_grep",  { cwd = vim.fn.getcwd(), hidden = true }), desc = "[G]rep (CWD)" },
        	{
					".fn",
					tb("find_files", { cwd = vim.fn.stdpath("config"), hidden = true }),
					desc = "Find nvim config",
				},
				{
					".gn",
					tb("live_grep", { cwd = vim.fn.stdpath("config"), hidden = true, no_ignore = true }),
					desc = "[G]rep nvim config",
				},
        

		
    --     -- GREP CONFIG
				-- {
				--   -- gc
				-- 	".c",
				-- 	tb("live_grep", { search_dirs = { vim.fn.stdpath("config") } }),
				-- 	desc = "Grep nvim config",
				-- },






        { "<leader>ss", tb("builtin"), desc = "Telescope pickers" },
				{ "sg", tb("live_grep"), desc = "[S]earch by [G]rep" },
				{ "so.", tb("oldfiles"), desc = "[S]earch [O]ld files" },
				{ "<leader><leader>", tb("buffers"), desc = "Buffers" },

				-- HELPERS
				{ ".sh", tb("help_tags"), desc = "Help" },
				{ ".sk", tb("keymaps"), desc = "Keymaps" },
				{ ".k", tb("keymaps"), desc = "Keymaps" },
				{ ".sw", tb("grep_string"), desc = "Word under cursor" },
				{ ".sd", tb("diagnostics"), desc = "Diagnostics" },
				{ ".sr", tb("resume"), desc = "Resume" },

				-- NVIM CONFIG
				{
					"<leader>fc",
					tb("find_files", { cwd = vim.fn.stdpath("config"), hidden = true }),
					desc = "Find nvim config",
				},
			


				-- BUFFERS
				{ "./", function()
						require("telescope.builtin").current_buffer_fuzzy_find(
							require("telescope.themes").get_dropdown({
								winblend = 9,
								previewer = false,
							})
						)
					end,
					desc = "Fuzzy in buffer",
				},

				-- GIT
				{ ".gc", tb("git_commits"), desc = "Git commits" },
				{ ".gb", tb("git_branches"), desc = "Git branches" },
				{ ".gs", tb("git_status"), desc = "Git status" },
				{ ".gf", tb("git_bcommits"), desc = "Git bcommits" },
			}
		end,

		lazy = true,
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			-- ripgrep args: agresywne, przewidywalne, cross-platform
			local rg_args = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			}

			-- ═══════════════════════════════════════════════════════════════
			-- TELESCOPE SETUP
			-- ═══════════════════════════════════════════════════════════════
			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = "❯ ",
					path_display = { "smart" },

					vimgrep_arguments = vim.list_extend(vim.deepcopy(rg_args), {
						"--hidden",
						"--glob",
						"!**/.git/*",
					}),

					file_ignore_patterns = {
						"%.git/",
						"^node_modules/",
						"^.venv/",
						"^dist/",
						"^build/",
						"%.o$",
    				"%.a$",
						"%.pyc$",
						"%.swp$",
						"%.bak$",
						"%.blend%d*$",
						"lazy%-lock%.json",
					},
					-- Mapowania nawigacyjne
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-h>"] = actions.preview_scrolling_up,
							["<C-l>"] = actions.preview_scrolling_down,
							-- OLD: ["<C-q>"] = actions.send_to_qflist + actions.open_qflist
							-- NEW: Mapowanie pod <C-a> (append)
							["<C-a>"] = actions.add_to_qflist + actions.open_qflist,
							["<M-a>"] = actions.add_selected_to_qflist + actions.open_qflist,
						 -- Tryb Insert (podczas pisania w wyszukiwarce)
              ["<C-Left>"] = "preview_scrolling_left",
              ["<C-Right>"] = "preview_scrolling_right",
              -- Lub wersja z Alt (często wygodniejsza)
              ["<S-h>"] = "preview_scrolling_left",
              ["<S-l>"] = "preview_scrolling_right",
          },
          n = { -- Tryb Normal
            ["h"] = "preview_scrolling_left",
            ["l"] = "preview_scrolling_right",
							["<C-a>"] = actions.add_to_qflist + actions.open_qflist,
						},
					},
				},
				pickers = {
					-- FAST: respektuje .gitignore
					find_files = {
						find_command = {
							"rg",
							"--files",
						},
					},

					-- ALL: absolutnie wszystko
					find_files_all = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--no-ignore",
							"--glob",
							"!**/.git/*",
						},
					},
					extensions = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})
    

			local t = require("telescope.builtin")

			-- -- ═══════════════════════════════════════════════════════════════
			-- -- CORE NAVIGATION - podstawowe skróty
			-- -- ═══════════════════════════════════════════════════════════════
			-- -- najpierw serch grep i search files
			-- vim.keymap.set("n", "sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			-- vim.keymap.set("n", "sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			-- vim.keymap.set("n", "so.", builtin.oldfiles, { desc = "[S]earch [O]ld files" })
			-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find buffers" })
			-- -- switching filewhere.
			-- -- /
			--
			-- -- ═══════════════════════════════════════════════════════════════
			-- -- SEARCH HELPERS - pomoc w wyszukiwaniu
			-- -- ═══════════════════════════════════════════════════════════════
			-- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			-- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			-- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			--
			-- -- ═══════════════════════════════════════════════════════════════
			-- -- NVIM CONFIG - przeszukiwanie konfiguracji Neovim
			-- -- ═══════════════════════════════════════════════════════════════
			-- -- Find files w config
			-- vim.keymap.set("n", "<leader>fc", function()
			-- 	builtin.find_files({
			-- 		cwd = vim.fn.stdpath("config"),
			-- 		hidden = true,
			-- 	})
			-- end, { desc = "[F]ind in nvim [C]onfig" })
			--
			-- -- Grep w config
			-- vim.keymap.set("n", "<leader>gc", function()
			-- 	builtin.live_grep({
			-- 		search_dirs = { vim.fn.stdpath("config") },
			-- 	})
			-- end, { desc = "[G]rep nvim [C]onfig" })
			--
			-- ═══════════════════════════════════════════════════════════════
			-- PROJECT DIRECTORIES - twoje katalogi robocze
			-- ═══════════════════════════════════════════════════════════════
			-- Current working directory
			vim.keymap.set("n", "<leader>fy", function()
				builtin.find_files({ cwd = vim.fn.getcwd(), hidden = true })
			end, { desc = "[F]ind cwd" })

			-- Code data (Windows)
			vim.keymap.set("n", "<leader>fd", function()

				builtin.find_files({
					cwd = "C:/code_data/",
					hidden = true,
					no_ignore = true,
					follow = true,
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--no-ignore",
						"--glob",
						"!**/.git/*",
					},
				})
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
			vim.keymap.set("n", "<leader>ga", function()
				builtin.live_grep({
					search_dirs = { "E:/Tools/BPY_Scripts/", vim.fn.getcwd(), vim.fn.stdpath("config") },
				})
			end, { desc = "[S]earch in [B]PY scripts" })

			vim.keymap.set("n", "<leader>gd", function()
				builtin.live_grep({
					search_dirs = { "C:/code_data/" },
				})
			end, { desc = "[S]earch in code_[D]ata" })

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
			-- CORE GIT - Telescope git_...
			-- ═══════════════════════════════════════════════════════════════
			--
			--
			-- vim.keymap.set("n", ",gc", t.git_commits, { desc = "Git: search commits." })
			-- vim.keymap.set("n", ",gb", t.git_branches, { desc = "Git: search branches." })
			-- vim.keymap.set("n", ",gs", t.git_status, { desc = "Git: status." })
			-- vim.keymap.set("n", ",gf", t.git_bcommits, { desc = "Git: bcommits." })

			-- -- ═══════════════════════════════════════════════════════════════
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

			-- Load extensions
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}

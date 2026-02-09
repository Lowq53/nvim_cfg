-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/lua/plugins/session_manager_dev.lua
return {
	{
		"Lowq53/nvim-session-manager",
		enabled = false, -- 🔴 WYŁĄCZONY
	},
	{
		dir = "C://dev//nvimdev//nvim-session-manager",
		name = "local-session-manager",
		lazy = false,

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "Smgr save", "Smgr restore", "Smgr list" },

		config = function()
			require("session_manager").setup({
				base_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/sessions"),
			})
		end,

		keys = {
			{ "<leader>sm", "<cmd>Ss main<CR>", desc = "Save Main Session" },
			{ "<leader>rm", "<cmd>Sr main<CR>", desc = "Restore Main Session" },
			{ "<leader>sl", "<cmd>Sl<CR>", desc = "List Sessions" },
		},
	},
	{
		-- opts nadpisuje config
		-- jedna sesja na katalog
		-- -- persisted.nvim - Automatyczne zarządzanie sesjami Neovim
		--
		-- WAŻNE INFORMACJE:
		-- • 1 sesja na katalog (lub 1 sesja na branch git jeśli use_git_branch = true)
		-- • Automatyczne zapisywanie (autosave = true) przy wyjściu z nvim
		-- • Automatyczne ładowanie (autoload = true) przy starcie w znanym katalogu
		-- • Sesje NIE są zapisywane w katalogach z ignored_dirs
		-- • Nazwa sesji = hash ze ścieżki katalogu (automatyczna)
		--
		-- KOMENDY:
		-- :Persisted save          - Ręczne zapisanie bieżącej sesji
		-- :Persisted load          - Załaduj sesję dla bieżącego katalogu (CWD)
		-- :Persisted load_last     - Załaduj ostatnio używaną sesję
		-- :Persisted select        - Picker do wyboru sesji (wbudowany)
		-- :Persisted delete        - Usuń sesję z listy
		-- :Persisted delete_current- Usuń bieżącą sesję
		-- :Persisted toggle        - Włącz/wyłącz nagrywanie sesji
		-- :Persisted start         - Rozpocznij nagrywanie (jeśli autosave = false)
		-- :Persisted stop          - Zatrzymaj nagrywanie
		--
		-- TELESCOPE:
		-- :Telescope persisted     - Przeglądaj sesje przez Telescope (jeśli załadowane)
		--
		-- LOKALIZACJA SESJI:
		-- Linux:   ~/.local/share/nvim/persisted/
		-- Windows: ~/AppData/Local/nvim-data/persisted/
		--
		"olimorris/persisted.nvim",
		version = "2.1.1",
		lazy = false,


    config = function()
		local save_dir = vim.fn.stdpath("data") .. "//persisted"

    if vim.fn.isdirectory(save_dir) == 0 then
      vim.fn.mkdir(save_dir, "p") -- gwarancja istnienia
    end
			require("persisted").setup({
				save_dir = save_dir, 
				autoload = true,
				autosave = true,
				--  niewiem ale fasl einaczej losowe crashe z gitem 
				use_git_branch = false,

				allowed_dirs = nil,
				ignored_dirs = { "~", "~/Downloads", "/" },
			})
			-- bezpiecne ladowanie rozszerzenie persisted dla Telescope
			pcall(function()
				require("telescope").load_extension("persisted")

				-- 1. Sprawdzenie bieżącego katalogu roboczego (PWD)
				vim.keymap.set("n", "<space>sp", function()
					print("Obecny katalog (PWD): " .. vim.fn.getcwd())
				end, { desc = "Persistence: PDW" })

				-- 2. Sprawdzenie statusu sesji
				vim.keymap.set("n", "<space>se", function()
					local persistence = require("persistence")
					local session_file = persistence.current()

					if vim.fn.filereadable(session_file) == 1 then
						print("✅ Sesja zapisana w: " .. session_file)
					else
						print("❌ Brak zapisanej sesji dla tego katalogu.")
					end
				end, { desc = "Persistence: Exists" })
			end)
		end,

		keys = {
			{ "<space>ss", "<cmd>Persisted save<cr>", desc = "Zapisz sesję" },
			{ "<space>sl", "<cmd>Persisted load<cr>", desc = "Załaduj dla CWD" },
			{ "<space>sL", "<cmd>Persisted load_last<cr>", desc = "Załaduj ostatnią" },
			{ "<space>sf", "<cmd>Persisted select<cr>", desc = "Wybierz sesję" },
			{ "<space>sd", "<cmd>Persisted delete<cr>", desc = "Usuń sesję" },
			{ "<space>sD", "<cmd>Persisted delete_current<cr>", desc = "Usuń bieżącą" },
			{ "<space>st", "<cmd>Persisted toggle<cr>", desc = "Toggle sesji" },
			{ "<space>sx", "<cmd>Persisted stop<cr>", desc = "Stop nagrywania" },
			{ "<space>sS", "<cmd>Persisted start<cr>", desc = "Start nagrywania" },
      { "<space>sc", 
      function()
          require("persisted").stop() -- satrymuje śledzienie sesjii
          vim.cmd("silent! %bd") -- zamknij wszystkie pliki
          print("crear sesion (recording)")
        end,
      desc = "Nowa pusta sesja"
		},
	},
}
}

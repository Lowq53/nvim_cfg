--[[
═══════════════════════════════════════════════════════════════════════
                      NVIM-TREESITTER KONFIGURACJA
═══════════════════════════════════════════════════════════════════════

CO TO JEST TREESITTER?
----------------------
Treesitter = inteligentny parser składni, który:
  ✓ Rozumie strukturę kodu (AST - Abstract Syntax Tree)
  ✓ Koloruje składnię precyzyjniej niż regex
  ✓ Umożliwia nawigację po kodzie
  ✓ Wspiera auto-indent, fold, komentarze kontekstowe

WYMAGANIA:
-----------
Windows: gcc/clang z MSYS2/MinGW lub Visual Studio (cl.exe)
Linux:   gcc/clang (sudo apt install build-essential)

INSTALACJA PARSERÓW:
--------------------
:TSInstall <język>        - zainstaluj parser
:TSUpdate                 - aktualizuj wszystkie parsery
:TSInstallInfo            - lista dostępnych parserów

OFICJALNE REPO:
---------------
https://github.com/nvim-treesitter/nvim-treesitter

═══════════════════════════════════════════════════════════════════════
]]

return {
	-- ======================== TREESITTER ========================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false, -- Nie lazy-loaduj tego pluginu
		config = function()
			-- ==================== WINDOWS FIX ====================
			-- Dodaj MSYS2/MinGW do PATH (tylko na Windows)
			if vim.fn.has("win32") == 1 then
				vim.env.PATH = vim.env.PATH .. ";C:\\msys64\\mingw64\\bin;C:\\msys64\\usr\\bin"
			end

			-- Konfiguracja kompilatora
			local install = require("nvim-treesitter.install")
			install.prefer_git = false -- Używaj curl+tar (szybsze)
			install.compilers = { "gcc", "clang", "cc" } -- Kolejność kompilatorów

			-- ==================== GŁÓWNA KONFIGURACJA ====================
			require("nvim-treesitter.configs").setup({
				-- Lista języków do auto-instalacji
				ensure_installed = {
					-- Podstawowe
					"lua",
					"vim",
					"vimdoc",
					"query", -- Treesitter query language

					-- Web dev
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"yaml",

					-- Backend/System
					"python",
					"go", -- Język Go
					"bash",
					"markdown",
					"markdown_inline",

					-- Opcjonalne (odkomentuj jeśli używasz):
					-- "rust",
					-- "c",
					-- "cpp",
					-- "java",
					-- "php",
				},

				-- Instaluj wszystkie parsery synchronicznie? (false = szybsze)
				sync_install = false,

				-- Auto-instaluj brakujące parsery przy otwarciu pliku
				auto_install = true,

				-- ==================== MODUŁY ====================

				-- Syntax highlighting
				highlight = {
					enable = true,
					-- disable = { "c", "rust" }, -- Wyłącz dla konkretnych języków
					additional_vim_regex_highlighting = false, -- Wyłącz regex highlighting (szybsze)
				},

				-- Auto-indentacja (eksperymentalne)
				indent = {
					enable = true,
					-- disable = { "python" }, -- Wyłącz dla problematycznych języków
				},

				-- Incremental selection (wizualne zaznaczanie scope)
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- Inicjuj zaznaczanie
						node_incremental = "grn", -- Powiększ zaznaczenie
						scope_incremental = "grc", -- Powiększ do scope
						node_decremental = "grm", -- Zmniejsz zaznaczenie
					},
				},
			})
		end,
	},

	-- ======================== DODATKOWE MODUŁY ========================

	-- Kontekstowe komentarze (obsługa JSX, Vue itp.)
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
}

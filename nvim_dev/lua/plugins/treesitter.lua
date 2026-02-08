--[[
═══════════════════════════════════════════════════════════════════════
              NVIM-TREESITTER - MAIN BRANCH (NVIM 0.11+)
═══════════════════════════════════════════════════════════════════════

⚠️  MAIN BRANCH = CAŁKOWICIE NOWE API ⚠️
----------------------------------------
- NIE MA setup() z tabelą konfiguracji!
- NIE MA ensure_installed, highlight.enable, indent.enable
- Highlighting włączasz przez vim.treesitter.start()
- Parsery instalujesz przez require('nvim-treesitter').install()

CO ROBI TREESITTER?
-------------------
✓ Parser składni = rozumie AST kodu
✓ Lepsze kolorowanie niż regex
✓ Auto-indent, fold, nawigacja

WYMAGANIA:
----------
- Neovim 0.11+ (masz 0.11.1 ✓)
- tree-sitter CLI w PATH
- Windows: gcc z MSYS2/MinGW LUB zig
- Linux: gcc/clang

KOMENDY:
--------
:TSInstall <język>   - zainstaluj parser
:TSUpdate            - aktualizuj parsery
:TSLog               - logi instalacji
:checkhealth nvim-treesitter

REPO:
-----
https://github.com/nvim-treesitter/nvim-treesitter

═══════════════════════════════════════════════════════════════════════
]]

return {
	-- ======================== TREESITTER MAIN BRANCH ========================
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- KRYTYCZNE dla nvim 0.11+
		lazy = false,
		build = ":TSUpdate",

		-- INIT = konfiguracja kompilatora PRZED załadowaniem pluginu
		-- init = function()
		-- 	-- Windows: dodaj MSYS2 do PATH
		-- 	if vim.fn.has("win32") == 1 then
		-- 		vim.env.PATH = vim.env.PATH .. ";C:\\msys64\\mingw64\\bin;C:\\msys64\\usr\\bin"
		-- 	end
		--
		-- 	-- Ustaw kompilator (głównie dla Windows)
		-- 	require("nvim-treesitter.install").compilers = { "gcc", "clang", "zig", "cc" }
		-- end,


		-- CONFIG = główna konfiguracja PO załadowaniu pluginu
		config = function()
			-- ==================== SETUP (MINIMALNY) ====================
			-- W main branch setup() NIE przyjmuje tabeli konfiguracji!
			require("nvim-treesitter").setup({})

			-- ==================== INSTALACJA PARSERÓW ====================
			-- Lista języków do zainstalowania
			local parsers = {
				"lua",
				"vim",
				"vimdoc",
				"query",

				-- Web
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
				"diff",

				-- Odkomentuj jeśli używasz:
				-- "rust",
				-- "c",
				-- "cpp",
				-- "java",
				-- "php",
			}

			-- ==================== LISTA PODSTAWOWYCH PARSERÓW ====================
			-- Te parsery zainstalują się przy starcie (tylko raz)

			local ts = require("nvim-treesitter")

			-- Instaluj podstawowe parsery synchronicznie przy pierwszym uruchomieniu
			ts.install(parsers, { summary = false }):wait(30000)

			-- ==================== AUTO-INSTALL NA FILETYPE ====================
			-- Lista języków do auto-instalacji (reszta języków)
			local auto_install_langs = {
				-- Web
				html = true,
				css = true,
				scss = true,
				javascript = true,
				typescript = true,
				tsx = true,
				json = true,
				yaml = true,

				-- Backend/System
				python = true,
				go = true, -- Go!
				bash = true,
				markdown = true,
				markdown_inline = true,

				-- Odkomentuj jeśli używasz:
				-- rust = true,
				-- c = true,
				-- cpp = true,
				-- java = true,
				-- php = true,
			}

			-- Funkcja do auto-instalacji i włączania highlighting
			local function auto_install_and_highlight(event)
				local ft = vim.bo[event.buf].filetype

				-- Pomiń puste/specjalne filetypes
				if not ft or ft == "" or ft == "help" or ft == "qf" then
					return
				end

				-- Sprawdź czy język jest na liście do auto-install
				if auto_install_langs[ft] then
					-- Zainstaluj parser (asynchronicznie, nie blokuje UI)
					local ok, task = pcall(ts.install, { ft }, { summary = false })
					if ok then
						-- Czekaj max 10 sekund na instalację
						task:wait(10000)
					end
				end

				-- Włącz highlighting dla buffora (nawet jeśli parser już był)
				pcall(vim.treesitter.start, event.buf, ft)
			end

			-- Autocmd dla auto-instalacji + highlighting
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_auto_install", { clear = true }),
				pattern = "*",
				callback = auto_install_and_highlight,
			})

			-- ==================== AUTO-INDENTACJA (OPCJONALNE) ====================
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_indent", { clear = true }),
				pattern = "*",
				callback = function(event)
					-- Wyłącz dla problematycznych języków
					local disabled = { "python", "yaml" }
					if vim.tbl_contains(disabled, vim.bo[event.buf].filetype) then
						return
					end
					vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- ==================== FOLDING (OPCJONALNE) ====================
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_folding", { clear = true }),
				pattern = "*",
				callback = function(event)
					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldenable = false -- Nie zwijaj domyślnie
				end,
			})
		end,
	},

	-- ======================== CONTEXT COMMENTSTRING ========================
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		branch = "main",
		lazy = false,
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}

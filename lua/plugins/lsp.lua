return {
	-- ======================== LSP & MASON ========================
	-- LSP = Language Server Protocol - zapewnia IntelliSense, goto definition, diagnostyki
	-- Mason = instalator/manager dla LSP serwerów, formattersów, linterów
	-- Nvim 0.11 u¿ywa nowego API: vim.lsp.config[] i vim.lsp.enable()
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim", -- instalator narz¿dzi
			"williamboman/mason-lspconfig.nvim", -- bridge mi¿dzy mason a lspconfig
			"saghen/blink.cmp", -- completion engine
			"j-hui/fidget.nvim", -- LSP progress notifications
		},
		config = function()
			-- Setup Mason (musi by¿ pierwszy)
			require("mason").setup()

			local mason_lsp = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Keymapy LSP (aktywuj¿ si¿ gdy LSP attachuje do bufora)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gR", vim.lsp.buf.references, "References")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				end,
			})

			-- Lista serwerów LSP z konfiguracj¿
			local servers = {
				-- ===== LUA =====
				-- Serwer: lua-language-server (zainstaluj: mason)
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } }, -- rozpoznaje 'vim' jako globaln¿
							workspace = { checkThirdParty = false },
						},
					},
				},

				-- ===== PYTHON =====
				-- Serwer: pyright (zainstaluj: mason)
				-- Alternatywy: pylsp, ruff-lsp
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},

				-- ===== JAVASCRIPT / TYPESCRIPT =====
				-- Serwer: typescript-language-server (zainstaluj: mason)
				-- Obs¿uguje: JS, TS, JSX, TSX
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
							},
						},
					},
				},

				-- ===== HTML =====
				-- Serwer: vscode-html-language-server (zainstaluj: mason)
				html = {},

				-- ===== CSS / SCSS / LESS =====
				-- Serwer: vscode-css-language-server (zainstaluj: mason)
				cssls = {
					settings = {
						css = { validate = true },
						scss = { validate = true },
						less = { validate = true },
					},
				},

				-- ===== JSON =====
				-- Serwer: vscode-json-language-server (zainstaluj: mason)
				jsonls = {},

				-- ===== BASH =====
				-- Serwer: bash-language-server (zainstaluj: mason + shellcheck)
				bashls = {},

				-- ===== VIM SCRIPT =====
				-- Serwer: vim-language-server (zainstaluj: mason)
				vimls = {},

				-- ===== POWERSHELL (Windows/Linux) =====
				-- Serwer: PowerShellEditorServices (zainstaluj: mason)
				-- WYMAGA: PowerShell 7+ (pwsh) zainstalowany w systemie!
				-- Windows: winget install Microsoft.PowerShell
				-- Linux: https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-linux
				powershell_es = {
					bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
					filetypes = { "ps1", "psm1", "psd1" },
					shell = "pwsh", -- u¿ywa PowerShell 7+
				},
			}

			-- Mason automatycznie instaluje serwery z listy
			mason_lsp.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			-- Setup ka¿dego serwera u¿ywaj¿c nowego API (Nvim 0.11)
			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				vim.lsp.config[server] = opts
				vim.lsp.enable(server)
			end
		end,
	},

	-- ======================== TREESITTER ========================
	-- Syntax highlighting + parsing kodu (lepsze ni¿ regex-based syntax)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"yaml",
				"markdown",
				"bash",
				"vim",
				"vimdoc",
				-- "powershell", -- parser dla PowerShell (opcjonalnie)
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	-- ======================== FORMATOWANIE ========================
	-- Conform.nvim = mened¿er formatterów (zast¿puje null-ls)
	-- U¿ywa zewn¿trznych narz¿dzi (prettier, black, itp.)
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			-- Formattery dla ka¿dego j¿zyka
			formatters_by_ft = {
				-- ===== LUA =====
				-- Narz¿dzie: stylua (zainstaluj: mason lub cargo install stylua)
				lua = { "stylua" },

				-- ===== PYTHON =====
				-- Narz¿dzia: isort (importy) + black (kod)
				-- Zainstaluj: pip install black isort LUB przez mason
				-- Kolejno¿¿ MA znaczenie: najpierw isort, potem black
				python = { "isort", "black" },

				-- ===== WEB (JS/TS/HTML/CSS) =====
				-- Narz¿dzie: prettier (zainstaluj: mason lub npm install -g prettier)
				-- Obs¿uguje wszystkie j¿zyki webowe
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },

				-- ===== BASH =====
				-- Narz¿dzie: shfmt (zainstaluj: mason lub go install)
				sh = { "shfmt" },
				bash = { "shfmt" },

				-- ===== POWERSHELL =====
				-- Formatter wbudowany w powershell_es LSP
				-- Nie trzeba osobnego formattera
			},

			-- AUTO-FORMATOWANIE przy zapisie (Ctrl+S)
			format_on_save = function(bufnr)
				-- Wy¿¿cz dla specjalnych buforów (oil.nvim, terminal)
				local ft = vim.bo[bufnr].filetype
				if ft == "oil" or ft == "terminal" then
					return
				end

				return {
					timeout_ms = 2000, -- max czas formatowania
					lsp_format = "fallback", -- u¿yj LSP tylko je¿li brak formattera
					async = false, -- synchroniczne (czeka na koniec)
				}
			end,

			-- Konfiguracja konkretnych formatterów (opcjonalne)
			formatters = {
				-- Przyk¿ad: prettier z custom opcjami
				prettier = {
					prepend_args = {
						"--tab-width=2",
						"--use-tabs=false",
					},
				},
				-- Przyk¿ad: black z maksymaln¿ d¿ugo¿ci¿ linii
				black = {
					prepend_args = { "--line-length=88" },
				},
			},
		},
		keys = {
			-- Manual format: <leader>f
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
	},

	-- ======================== LAZYDEV (Lua Development) ========================
	-- Autokompletowanie dla Neovim Lua API (vim.api.*, itp.)
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
}

-- ====================================================================
-- NOTATKI I LINKI
-- ====================================================================
--
-- === INSTALACJA NARZ¿DZI ===
-- 1. Otwórz Neovim i uruchom: :Mason
-- 2. Znajd¿ i zainstaluj (naci¿nij 'i'):
--    LSP: lua-language-server, pyright, typescript-language-server,
--         vscode-langservers-extracted (html/css/json), bash-language-server,
--         vim-language-server, powershell-editor-services
--    Formatters: stylua, black, isort, prettier, shfmt
--    Linters: shellcheck (dla bash)
--
-- === DODATKOWE NARZ¿DZIA (opcjonalne) ===
-- - ruff: szybszy linter/formatter dla Python (alternatywa dla black+isort)
-- - eslint: linter dla JavaScript/TypeScript
-- - markdownlint: linter dla Markdown
--
-- === PRZYDATNE LINKI ===
-- [1] Neovim 0.11 LSP Overview:
--     https://gpanders.com/blog/whats-new-in-neovim-0-11/
--
-- [2] Native LSP Setup Guide:
--     https://tduyng.com/blog/neovim-lsp-native/
--
-- [3] Conform.nvim Documentation:
--     https://github.com/stevearc/conform.nvim
--
-- [4] LSP Config Documentation:
--     https://neovim.io/doc/user/lsp.html
--
-- [5] Mason.nvim (tool installer):
--     https://github.com/williamboman/mason.nvim
--
-- [6] Nvim-lspconfig Server Configs:
--     https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
-- === KOMENDY ===
-- :Mason           - otwórz interfejs instalacji narz¿dzi
-- :LspInfo         - poka¿ aktywne LSP serwery
-- :ConformInfo     - poka¿ dost¿pne formattery dla obecnego pliku
-- :TSUpdate        - zaktualizuj parsery Treesitter
--
-- === TROUBLESHOOTING ===
-- Je¿li LSP nie dzia¿a:
-- 1. :checkhealth vim.lsp     - sprawd¿ diagnostyk¿ LSP
-- 2. :LspLog                  - zobacz logi serwera
-- 3. Upewnij si¿ ¿e narz¿dzie jest zainstalowane (:Mason)
-- 4. Sprawd¿ czy plik ma odpowiedni filetype (:set ft?)
--
-- Je¿li formatowanie nie dzia¿a:
-- 1. :ConformInfo             - sprawd¿ dost¿pne formattery
-- 2. Upewnij si¿ ¿e formatter jest zainstalowany
-- 3. Sprawd¿ czy filetype jest w formatters_by_ft
--
-- === POWERSHELL SPECYFICZNE ===
-- 1. Zainstaluj PowerShell 7+:
--    Windows: winget install Microsoft.PowerShell
--    Linux: https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-linux
-- 2. Sprawd¿ czy pwsh dzia¿a: uruchom `pwsh` w terminalu
-- 3. Mason zainstaluje PowerShellEditorServices automatycznie
-- 4. Je¿li problemy, sprawd¿: :checkhealth mason
-- 5. Opcjonalnie: dodaj parser treesitter dla PowerShell:
--    https://github.com/airbus-cert/tree-sitter-powershell

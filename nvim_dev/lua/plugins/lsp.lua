return {
	-- ======================== LSP & MASON ========================
	-- LSP = Language Server Protocol - zapewnia IntelliSense, goto definition, diagnostyki
	-- Mason = instalator/manager dla LSP serwerów, formattersów, linterów
	-- Nvim 0.11 u¿ywa nowego API: vim.lsp.config[] i vim.lsp.enable()
	--
	-- gd   - Goto Definition (skocz do definicji)
	-- gR   - References (poka¿ wszystkie u¿ycia)
	-- K    - Hover Documentation (dokumentacja pod kursorem)
	-- <leader>rn - Rename Symbol (zmie¿ nazw¿)
	-- <leader>ca - Code Action (akcje kodu)
	-- Ctrl-Space - otwórz suggestions ctrl-n
	-- Ctrl-n/p   - nast¿pny/poprzedni
	-- Ctrl-y     - potwierd¿
	-- Ctrl-e     - zamknij
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
					map("<c-k>", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

					-- Diagnostic
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("gi", vim.lsp.buf.implementation, "Goto Implementation")
					map("gr", vim.lsp.buf.references, "Show References")
					map("<c-i>", vim.lsp.buf.signature_help, "Signature Help")
					map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
					map("<leader>q", vim.diagnostic.setloclist, "Diagnostic List")

					vim.keymap.set("n", "q", function()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							local buf = vim.api.nvim_win_get_buf(win)
							local ft = vim.bo[buf].filetype
							if ft == "markdown" then -- hover window u¿ywa markdown
								vim.api.nvim_win_close(win, true)
								return
							end
						end
					end, { buffer = event.buf, desc = "Close hover window" })

					-- workspace
					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspac")
					map("<leader>wl", function()
						print(vim.inspect(vim.lspe.buf.list_workspace_folders()))
					end, "List Workspace")

					-- format & type
					map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
					-- <leader>f ju¿ masz w conform.nvim

					-- inlayHints(podpowiedzi w kodize)
					vim.lsp.inlay_hint.enable(true) -- w¿¿cz globalnie
					-- toggle na klawisz:
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "Toggle Inlay Hints")

					--codelens (akcje w kodzie)
					vim.lsp.codelens.refresh() -- od¿wie¿
					-- w autocmd:
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
						callback = function()
							-- BEZPIECZNIK: Nie rób nic, je¿li to terminal lub specjalne okno
							if vim.bo.buftype ~= "" then
								return
							end

							-- Sprawd¿, czy klient LSP obs¿uguje codelens
							local clients = vim.lsp.get_active_clients({ bufnr = 0 })
							if #clients == 0 then
								return
							end -- Szybkie wyj¿cie, je¿li brak LSP

							for _, client in ipairs(clients) do
								if client.supports_method("textDocument/codeLens") then
									--vim.lsp.codelens.refresh()
									break
								end
							end
						end,
					})

					-- document sympols
					map("<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
					map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

					-- Folding (sk¿adanie kodu):
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"

					-- Semantic Tokens (kolorowanie):
					-- w¿¿czone automatycznie, ale mo¿na wy¿¿czy¿:
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							client.server_capabilities.semanticTokensProvider = nil
						end,
					})
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
							workspace = {
								checkThirdParty = false,
								-- TO JEST KLUCZOWE: nie skanuj zb¿dnych rzeczy
								ignoreDir = { ".git", "node_modules", ".cache", "lua-language-server" },
								-- Nie indeksuj plików powy¿ej pewnej wielko¿ci
								maxPreload = 2000,
								preloadFileSize = 1000,
							},
							telemetry = { enable = false }, -- wy¿¿cz zb¿dne wysy¿anie danych
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
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},

				-- ===== RUST =====
				-- Serwer: rust-analyzer (zainstaluj: mason)
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								allFeatures = true,
								command = "clippy", -- u¿ywa clippy zamiast cargo check dla lepszych sugestii
							},
							procMacro = {
								enable = true,
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

				-- ===== BAmH =====
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
				biome = {}, -- dodany je¿li u¿ywasz jako linter/formatter
				ast_grep = {}, -- wymaga zainstalowanego ast-grep
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

	-- ======================== FORMATOWANIE ========================
	-- Conform.nvim = mened¿er formatterów (zast¿puje null-ls)
	-- U¿ywa zewn¿trznych narz¿dzi (prettier, black, itp.)
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			-- 1. Definicja silników formatowania
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				rust = { "rustfmt" }, -- Zmieniono na standardowy rustfmt
				-- POWERSHELL
				pwsh = { "powershell_es" },
				ps1 = { "powershell_es" },
			},

			-- 2. LOGIKA AUTO-FORMATOWANIA (Musi by¿ w opts!)
			format_on_save = function(bufnr)
				-- Wy¿¿cz dla konkretnych plików lub je¿li flaga jest ustawiona
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				-- Wy¿¿cz dla specjalnych typów plików (np. Oil lub Terminal)
				local ft = vim.bo[bufnr].filetype
				if ft == "oil" or ft == "terminal" then
					return
				end

				return {
					timeout_ms = 2000,
					lsp_fallback = true,
					async = false,
				}
			end,

			-- 3. Konfiguracja konkretnych narz¿dzi
			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
				},
				black = {
					prepend_args = { "--line-length", "88" },
				},
			},
		},
		-- 4. SKRÓTY KLAWISZOWE
		keys = {
			{
				"<leader>fb",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
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

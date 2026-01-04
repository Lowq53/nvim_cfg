return {
	-- ======================== LSP & MASON ========================
	-- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			"j-hui/fidget.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lsp = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Autocmd do mapowania LSP keys
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gR", vim.lsp.buf.references, "References")
					map("K", vim.lsp.buf.hover, "Hover")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				end,
			})

			-- Lista serwerów
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
						},
					},
				},
				pyright = {},
				tsserver = {},
				html = {},
				ts_ls = {},
				powershell_es = {},
				bashls = {},
				vimls = {},
				cssls = {
					settings = {
						scss = { validate = true },
						less = { validate = true },
						css = { validate = true },
					},
				},
			}

			-- Mason instaluje serwery
			mason_lsp.setup({ ensure_installed = vim.tbl_keys(servers) })

			-- Setup ka¿dego serwera LSP zgodnie z API 3.x
			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				opts.on_attach = function(client, bufnr)
					-- Zachowujemy Twoje mapowania LSP
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gR", vim.lsp.buf.references, "References")
					map("K", vim.lsp.buf.hover, "Hover")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				end

				-- Poprawny setup dla nvim-lspconfig 3.x
				lspconfig[server].setup(opts)
			end
		end,
	},
	-- ======================== TREESITTER ========================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"typescript",
				"markdown",
				"vimdoc",
				"html",
				"css",
				"scss",
				"json",
			},
			highlight = { enable = true },
		},
	},

	-- ======================== FORMAT & TOOLS ========================
	{
		-- Conform:
		-- odpala zewn¿trzne, najlepsze formatery
		-- fallback do LSP tylko gdy brak narz¿dzia
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			-- Co formatowa¿ i czym
			formatters_by_ft = {
				-- ===== Lua =====
				lua = { "stylua" }, -- standard w ¿wiecie Neovim

				-- ===== Python =====
				python = { "isort", "black" }, -- kolejno¿¿ ma znaczenie

				-- ===== Web =====
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

				-- ===== Shell =====
				sh = { "shfmt" },
				bash = { "shfmt" },

				-- ===== PowerShell (Windows) =====
				ps1 = { "psscriptanalyzer" },
			},

			-- Formatowanie przy zapisie
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback", -- u¿yj LSP tylko je¿li brak formattera
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- ======================== LSP & MASON ======================== -- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿ { "neovim/nvim-lspconfig", event = "BufReadPre", dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp", "j-hui/fidget.nvim", }, config = function() require("mason").setup() local mason_lsp = require("mason-lspconfig") local capabilities = require("blink.cmp").get_lsp_capabilities() vim.api.nvim_create_autocmd("LspAttach", { callback = function(event) local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc }) end map("gd", vim.lsp.buf.definition, "Goto Definition") map("gR", vim.lsp.buf.references, "References") map("K", vim.lsp.buf.hover, "Hover") map("<leader>rn", vim.lsp.buf.rename, "Rename") map("<leader>ca", vim.lsp.buf.code_action, "Code Action") end, }) local servers = { lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false }, }, }, }, pyright = {}, ts_ls = {}, html = {}, cssls = {}, powershell_es = {}, vimls = {}, bashls = {}, } -- Mason zainstaluje serwery mason_lsp.setup({ ensure_installed = vim.tbl_keys(servers), }) for server, opts in pairs(servers) do opts.capabilities = capabilities vim.lsp.config[server] = opts vim.lsp.enable(server) end end, }, -- ======================== TREESITTER ======================== { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = { ensure_installed = { "lua", "python", "javascript", "typescript", "markdown", "vimdoc" }, highlight = { enable = true }, }, }, -- ======================== FORMAT & TOOLS ======================== { "stevearc/conform.nvim", opts = { format_on_save = { lsp_format = "fallback" } } }, { "folke/lazydev.nvim", ft = "lua", opts = {} }, }dla najnowszej wersjiii nvim 0.11. potrzebuje ustawic conform.nvim { "stevearc/conform.nvim", opts = { format_on_save = { lsp_format = "fallback" } } }, obecnie napisz w komentarzu za co odpowiada ect i potrzebuje takie jezyki jak pyton -narzedzia dev dla - jezyków webowych obecnie najczesciej wybieranych (bedetworzy¿ strone) standarwowo lua winows - powershel bash zrob fajne notanki zwiez¿e mozesz tez podac linki do bloga szeroko opisujacego temat i to co potrzebne do nvim python, lua scc html?-- ======================== LSP & MASON ======================== -- ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿ { "neovim/nvim-lspconfig", event = "BufReadPre", dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp", "j-hui/fidget.nvim", }, config = function() require("mason").setup() local mason_lsp = require("mason-lspconfig") local capabilities = require("blink.cmp").get_lsp_capabilities() vim.api.nvim_create_autocmd("LspAttach", { callback = function(event) local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc }) end map("gd", vim.lsp.buf.definition, "Goto Definition") map("gR", vim.lsp.buf.references, "References") map("K", vim.lsp.buf.hover, "Hover") map("<leader>rn", vim.lsp.buf.rename, "Rename") map("<leader>ca", vim.lsp.buf.code_action, "Code Action") end, }) local servers = { lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false }, }, }, }, pyright = {}, ts_ls = {}, html = {}, cssls = {}, powershell_es = {}, vimls = {}, bashls = {}, } -- Mason zainstaluje serwery mason_lsp.setup({ ensure_installed = vim.tbl_keys(servers), }) for server, opts in pairs(servers) do opts.capabilities = capabilities vim.lsp.config[server] = opts vim.lsp.enable(server) end end, }, -- ======================== TREESITTER ======================== { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = { ensure_installed = { "lua", "python", "javascript", "typescript", "markdown", "vimdoc" }, highlight = { enable = true }, }, }, -- ======================== FORMAT & TOOLS ======================== { "stevearc/conform.nvim", opts = { format_on_save = { lsp_format = "fallback" } } }, { "folke/lazydev.nvim", ft = "lua", opts = {} }, }dla najnowszej wersjiii nvim 0.11. potrzebuje ustawic conform.nvim { "stevearc/conform.nvim", opts = { format_on_save = { lsp_format = "fallback" } } }, obecnie napisz w komentarzu za co odpowiada ect i potrzebuje takie jezyki jak pyton -narzedzia dev dla - jezyków webowych obecnie najczesciej wybieranych (bedetworzy¿ strone) standarwowo lua winows - powershel bash zrob fajne notanki zwiez¿e mozesz tez podac linki do bloga szeroko opisujacego temat i to co potrzebne do nvim python, lua scc html? opts = {} },
	},
}

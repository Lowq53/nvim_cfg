return {
	-- ======================== LSP & MASON ========================
	-- standrdowy protoków umożliwiajacy edytorom komunikację z z ewnetrznym serwerami jezykowymi, które dostarczają inteligentych funkcji opartych na analizie całego projetku
	-- ======================== AUTOCOMPLETION ========================
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
			-- Capabilities z blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Keymaps po uruchomieniu LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				end,
			})

			-- Lua LSP
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim", "require" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- PowerShell LSP
			vim.lsp.config("powershell_es", {
				capabilities = capabilities,
				cmd = { "pwsh", "-NoProfile", "-Command", "PowerShellEditorServices" },
				filetypes = { "ps1", "psm1", "psd1" },
				settings = {
					powershell = {
						scriptAnalysis = { enable = true },
					},
				},
			})
		end,
	},

	{
		"mason-org/mason.nvim",
		opts = {},
		build = ":MasonUpdate",
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			automatic_installation = false,
		},
	},

	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-- ======================== TREESITTER ========================
	-- szybka przyrostowa biblioteka parsujaca, buduje drewo składniowe kodu
	-- zapenia dokłądniejsze podswietlanie składni , składnie kodu i inee funkcje opearte na strukturze drzewa
	-- kolorownie składni nawigacja
	{
		"nvim-treesitter/nvim-treesitter",
		ranch = "main",
		build = ":TSUpdate",

	config = function()
    local ts = require("nvim-treesitter")
    
    -- Install parsers
    ts.install({
      "bash", "c", "diff", "html", "lua", "luadoc", "markdown",
      "markdown_inline", "query", "vim", "vimdoc", "python",
      "javascript", "typescript", "json", "yaml", "toml",
    })
    
    -- Enable highlighting autocmd
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        vim.treesitter.start()
      end,
    })
    
    -- Enable indent (experimental)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},

	-- ======================== AUTOCOMPLETION ========================
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			opts = {},
		},
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		},
	},

	-- ======================== AUTO-FORMAT ========================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>aa",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "[a]all",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				-- Dodaj formatery według potrzeb
				-- lua = { "stylua" },
				-- python = { "isort", "black" },
			},
		},
	},

	-- ======================== PYTHON DOCSTRING ========================
	{
		"kkoomen/vim-doge",
	},

	-- ======================== DODATKOWE NARZĘDZIA ========================
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = (function()
			if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
				return
			end
			return "make install_jsregexp"
		end)(),
	},

	{
		--https://github.com/pocco81/auto-save.nvim
		"pocco81/auto-save.nvim",
		event = { "InsertLeave", "TextChanged" },
		lazy = false,
		opts = {
			trigger_events = { "InsertLeave", "TextChanged" },
			enabled = true,
			write_all_buffers = false,
			debounce_delay = 551500,
			execution_message = {
				message = function()
					return ("autosave: saved at " .. vim.fn.strftime("%H:%M:%S"))
				end,
				dim = 0.18,
				cleaning_interval = 1250,
			},
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")
				return fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
			end,
		},
		config = function(_, opts)
			require("auto-save").setup(opts)
		end,
	},
}

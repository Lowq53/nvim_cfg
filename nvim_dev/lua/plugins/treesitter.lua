return {
	-- ======================== TREESITTER ========================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			vim.env.PATH = vim.env.PATH .. ";C:\\msys64\\mingw64\\bin;C:\\msys64\\usr\\bin"

			-- Sprawdź czy configs istnieje
			-- Ustaw kompilator na clang/gcc z npm
			require("nvim-treesitter.install").compilers = { "clang", "gcc", "cc" }
			require("nvim-treesitter.install").prefer_git = true
			local has_configs, configs = pcall(require, "nvim-treesitter.configs")
			if not has_configs then
				-- Użyj starszego API
				local has_install, install = pcall(require, "nvim-treesitter.install")
				if has_install then
					install.compilers = { "gcc" }
					install.prefer_git = false
				end
				-- vim.notify("nvim-treesitter: używam uproszczonej konfiguracji", vim.log.levels.WARN)
				return
			end

			require("nvim-treesitter.install").compilers = { "gcc" }
			require("nvim-treesitter.install").prefer_git = false

			configs.setup({
				ensure_installed = { "html", "css", "javascript", "typescript", "tsx", "lua" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = { enable_autocmd = false },
	},
}

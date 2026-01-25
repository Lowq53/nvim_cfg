-- # extendion tag for plugins help
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

---@class PluginHelpModule
---@field plugin_help_map table<string, string> Mapowanie nazw pluginów na tagi help.
local M = {}

-- Słownik mapujący nazwy z Lazy do nazw plików help
-- Większość pluginów używa nazwy bez ".nvim" lub ".lua"
---Mapa translacji nazw pluginów z menedżera lazy.nvim na konkretne pliki dokumentacji.
---Niektóre pluginy mają niestandardowe nazwy plików .txt w folderze doc/.

---Otwiera dokumentację help dla podanego pluginu.
---@param opts table Obiekt parametrów przekazany przez nvim_create_user_command (opts.args).


print("Help setup: Konfiguracja załadowana pomyślnie!")
M.plugin_help_map = {
	["auto-save.nvim"] = "auto-save.txt",
	["blink.cmp"] = "blink.txt",
	["Comment.nvim"] = "comment.txt",
	["LuaSnip"] = "luasnip.txt",
	["oil.nvim"] = "oil.txt",
	["telescope.nvim"] = "telescope.txt",
	["fidget.nvim"] = "fidget.txt",
	["gitsigns.nvim"] = "gitsigns.txt",
	["nvim-lspconfig"] = "lspconfig.txt",
	["nvim-treesitter"] = "nvim-treesitter.txt",
	["which-key.nvim"] = "which-key.txt",
}

---Otwiera dokumentację help dla podanego pluginu.
---@param opts table Obiekt parametrów przekazany przez nvim_create_user_command (opts.args).
function M.open_plugin_help(opts)
	local plugin_name = opts.args
	local help_file = M.plugin_help_map[plugin_name] or (plugin_name:gsub("%.nvim$", ""):gsub("%.lua$", ""))

	local ok = pcall(vim.cmd, "help " .. help_file)
	if not ok then
		vim.notify("Help tag not found for: " .. plugin_name, vim.log.levels.WARN)
	end
end

-- Rejestracja PH jako aliasu dla PHelp
vim.api.nvim_create_user_command("PH", M.open_plugin_help, {
	nargs = 1,
	complete = function()
		return vim.tbl_keys(require("lazy").plugins())
	end,
})
-- Przykład użycia dla oil.nvim:
-- 1. Wywołanie komendy: :PHelp oil.nvim
-- 2. Funkcja sprawdza M.plugin_help_map["oil.nvim"] -> wynik: "oil.txt"
-- 3. Wykonuje: vim.cmd("help oil.txt")

vim.api.nvim_create_user_command("PHelp", M.open_plugin_help, {
	nargs = 1,
	complete = function()
		local keys = {}
		for k, _ in pairs(require("lazy").plugins()) do
			table.insert(keys, k)
		end
		table.sort(keys)
		return keys
	end,
	desc = "Open help for a specific plugin managed by Lazy",
})

return M

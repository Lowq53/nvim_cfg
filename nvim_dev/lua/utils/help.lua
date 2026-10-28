-- ═══════════════════════════════════════════════════════════════════
-- PLUGIN HELP MODULE
-- ═══════════════════════════════════════════════════════════════════

---@class PluginHelpModule
---@field plugin_help_map table<string, string>
local M = {}

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

---@param opts table
function M.open_plugin_help(opts)
	local plugin_name = opts.args
	local help_file = M.plugin_help_map[plugin_name] or (plugin_name:gsub("%.nvim$", ""):gsub("%.lua$", ""))

	local ok = pcall(vim.cmd, "help " .. help_file)
	if not ok then
		vim.notify("Help tag not found for: " .. plugin_name, vim.log.levels.WARN)
	end
end

function M.setup()
	-- Komenda :PH
	vim.api.nvim_create_user_command("PH", M.open_plugin_help, {
		nargs = 1,
		complete = function()
			return vim.tbl_keys(require("lazy").plugins())
		end,
	})

	-- Komenda :PHelp
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

	--vim.notify("PluginHelp: loaded", vim.log.levels.DEBUG)
end

return M

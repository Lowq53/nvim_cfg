-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/init.luy
-- ~/.config/nvim/init.lua
-- only require here pls
local debug_log = vim.fn.stdpath("cache") .. "/nvim-diagnostic-debug.log"

local function log_event(name, data)
	vim.fn.writefile({
		os.date("%Y-%m-%d %H:%M:%S"),
		name,
		vim.inspect(data),
		"------------------------------",
	}, debug_log, "a")
end
for _, name in ipairs({ "jump", "goto_next", "goto_prev" }) do
	local orig = vim.diagnostic[name]
	if orig then
		vim.diagnostic[name] = function(...)
			log_event("vim.diagnostic." .. name, { args = { ... }, trace = debug.traceback("", 2) })
			return orig(...)
		end
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		log_event("LspAttach", {
			client = client and client.name,
			id = args.data.client_id,
			bufnr = args.buf,
			file = vim.api.nvim_buf_get_name(args.buf),
		}) -- Diagnostics
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		vim.diagnostic.jump({ count = 1, float = true })
		vim.diagnostic.jump({ count = -1, float = true })
		-- LSP Toggle
		local lsp_enabled = true
		function ToggleLSP()
			if lsp_enabled then
				vim.lsp.stop_client(vim.lsp.get_clients())
				vim.notify("LSP disabled", vim.log.levels.WARN)
			else
				vim.cmd("edit")
				vim.notify("LSP enabled", vim.log.levels.INFO)
			end
			lsp_enabled = not lsp_enabled
		end

		vim.keymap.set("n", "<leader>ls", ":ToggleLSP<CR>", { desc = "LSP: Toggle" })
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function(args)
		local diagnostics = vim.diagnostic.get(args.buf)

		log_event("DiagnosticChanged", {
			bufnr = args.buf,
			count = #diagnostics,
		})
	end,
})
require("config.settings")
require("config.autocmd")
require("keymaps")
-- new aproach to loading with .setup() as cunction
-- pros: / lazy load / full control / kolejność deterministic / able to confgure / easy debug / best practices
require("utils").setup()

-- all confg.tmp.lua moved to utils
--require("config.tmp")

-- lub jeśli używasz mingw32-make:
require("config.lazy")
--require("config.terminal")

require("config.pwsh")
require("config.ui").setup()

-- Pobierz ścieżkę do folderu 'tmp' w Twojej konfiguracji Neovima
local tmp_dir = vim.fn.stdpath("config") .. "/lua/tmp"

-- Sprawdź, czy folder istnieje, i przejdź przez wszystkie pliki
if vim.fn.isdirectory(tmp_dir) == 1 then
	for _, file in ipairs(vim.fn.readdir(tmp_dir)) do
		-- Ładuj tylko pliki z rozszerzeniem .lua
		if file:match("%.lua$") then
			local module_name = file:gsub("%.lua$", "")
			require("tmp." .. module_name)
		end
	end
end
-- vim.g.clipboard = {
--   name = "windows-clipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   paste = {
--     ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--     ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--   },
--   cache_enabled = 0,

-- -- # those should go to /keymaps - to correct - area
-- --
-- -- text manipulation i insert mode
--
-- -- Move cursor in Insert Mode
-- -- vim.keymap.set("i", "<S-h>", "<Left>", { desc = "Move left" })
-- -- vim.keymap.set("i", "<S-l>", "<Right>", { desc = "Move right" })
-- -- vim.keymap.set("i", "<S-k>", "<Up>", { desc = "Move up" })
-- -- vim.keymap.set("i", "<S-j>", "<Down>", { desc = "Move down" })
--
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
-- vim.keymap.set("n", "gf", function()
-- 	-- Spróbuj LSP definition
-- 	vim.lsp.buf.definition()
-- end, { desc = "Go to definition" })
--
-- -- LUB lepsze rozwiązanie - gf dla ścieżek względnych:
-- vim.keymap.set("n", "gf", function()
-- 	local file = vim.fn.expand("<cfile>")
-- 	local current_file = vim.fn.expand("%:p:h")
-- 	local full_path = vim.fn.resolve(current_file .. "/" .. file)
--
-- 	if vim.fn.filereadable(full_path) == 1 then
-- 		vim.cmd("edit " .. full_path)
-- 	else
-- 		vim.notify("Nie znaleziono: " .. file, vim.log.levels.ERROR)
-- 	end
-- end)
--
-- local servers = {
-- 	"ast_grep",
-- 	"bashls",
-- 	"biome",
-- 	"cssls",
-- 	"html",
-- 	"jsonls",
-- 	"lua_ls",
-- 	"powershell_es",
-- 	"pyright",
-- 	"ts_ls",
-- 	"vimls",
-- }
--
-- -- Enable all servers
-- for _, server in ipairs(servers) do
-- 	vim.lsp.enable(server)
-- end
--
-- -- Configure lua_ls for Neovim
-- vim.lsp.config("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = { globals = { "vim" } },
-- 			workspace = { checkThirdParty = false },
-- 		},
-- 	},
-- })
--
vim.lsp.enable({
	"ast_grep",
	"bashls",
	"biome",
	"cssls",
	"html",
	"jsonls",
	"lua_ls",
	"powershell_es",
	"pyright",
	"ts_ls",
	"vimls",
})

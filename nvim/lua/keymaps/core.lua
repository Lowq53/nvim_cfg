-- ═══════════════════════════════════════════════════════════════════════════
-- CORE KEYMAPS - Basic Navigation & Editing
-- Path: C:\Users\LOWq_53\AppData\Local\nvim\lua\config\keymaps\core.lua
-- ═══════════════════════════════════════════════════════════════════════════

local vim = vim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- ═══════════════════════════════════════════════════════════════════════════
-- ► LEADER KEYS
-- ═══════════════════════════════════════════════════════════════════════════

-- Simulated second leader with comma
vim.keymap.set("n", ",f", function()
	print("Simulated leader with ','")
end, { desc = "Simulated comma leader" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► AUTO-PAIRS (Insert Mode)
-- ═══════════════════════════════════════════════════════════════════════════

map("i", "(", "()<Left>", opts)
map("i", "[", "[]<Left>", opts)
map("i", "{", "{}<Left>", opts)
map("i", '"', '""<Left>', opts)
map("i", "'", "''<Left>", opts)

-- ═══════════════════════════════════════════════════════════════════════════
-- ► SMART BUFFER/WINDOW CLOSING
-- ═══════════════════════════════════════════════════════════════════════════

-- Smart quit: handles terminal, lazy, help, normal buffers differently
vim.keymap.set("n", "<A-q>", function()
	local buftype = vim.bo.buftype
	local filetype = vim.bo.filetype

	if buftype == "terminal" then
		vim.cmd("bd!") -- Close terminal
	elseif buftype == "nofile" then
		vim.cmd("q") -- Close Lazy.nvim
	elseif filetype == "help" then
		vim.cmd("q") -- Close help window
	else
		vim.cmd("q") -- Close normal buffer
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-A-c>", ":q", { desc = "Force quit" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► NAVIGATION - Centered Scrolling (Primeagen style)
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "K", "Kzz", { desc = "Move up (centered)" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► SEARCH & REPLACE
-- ═══════════════════════════════════════════════════════════════════════════

-- Search and replace word under cursor
vim.keymap.set(
	"n",
	"<leader>sp",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ noremap = true, silent = false, desc = "Replace word under cursor" }
)

-- Open search
vim.keymap.set("n", "<C-f>", "/", { noremap = true, silent = false, desc = "Search" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► MOVING LINES (Alt+j/k or Arrow keys)
-- ═══════════════════════════════════════════════════════════════════════════

-- Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })

-- Visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })
vim.keymap.set("v", "<A-down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► CLIPBOARD OPERATIONS (VSCode-like)
-- ═══════════════════════════════════════════════════════════════════════════

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Select all
vim.keymap.set("n", "<C-S-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► FILE OPERATIONS
-- ═══════════════════════════════════════════════════════════════════════════

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- Close buffer
vim.keymap.set("n", "<C-ww>", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Delete current buffer" })

-- Redo
vim.keymap.set("n", "<C-y>", "<C-yzz>", { noremap = true, silent = true, desc = "Redo (centered)" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► BUFFER NAVIGATION
-- ═══════════════════════════════════════════════════════════════════════════

-- Tab-style navigation
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-S-Tab>", ":bprev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- PageUp/PageDown navigation
vim.keymap.set("n", "<C-PageUp>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-PageDown>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► WINDOW NAVIGATION
-- ═══════════════════════════════════════════════════════════════════════════

-- Arrow keys
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► TERMINAL MODE
-- ═══════════════════════════════════════════════════════════════════════════

-- Escape to normal mode in terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Open terminal in vertical split
vim.keymap.set("n", "<M-F1>", ":vsplit | terminal<CR>", { desc = "Open terminal (vsplit)" })

-- Split window vertically
vim.keymap.set("n", "<A-F2>", "<C-w>v", { desc = "Split window vertically" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► FILE TREE (nvim-tree)
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<leader>y", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>yf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true, desc = "Find file in NvimTree" })
vim.keymap.set("n", "<leader>yr", ":NvimTreeRefresh<CR>", { noremap = true, silent = true, desc = "Refresh NvimTree" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► LSP KEYMAPS
-- ═══════════════════════════════════════════════════════════════════════════

-- Basic LSP operations
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code action" })

-- Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })

-- Diagnostics
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- LSP Toggle
local lsp_enabled = true
function ToggleLSP()
	if lsp_enabled then
		vim.lsp.stop_client(vim.lsp.get_active_clients())
		vim.notify("LSP disabled", vim.log.levels.WARN)
	else
		vim.cmd("edit")
		vim.notify("LSP enabled", vim.log.levels.INFO)
	end
	lsp_enabled = not lsp_enabled
end

vim.keymap.set("n", "<leader>ls", ":LspStop<CR>", { desc = "LSP Stop" })
vim.keymap.set("n", "<leader>lS", ":LspStart<CR>", { desc = "LSP Start" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► LAZY.NVIM PLUGIN MANAGER
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<leader>lc", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Update plugins" })
vim.keymap.set("n", "<leader>lL", "<cmd>Lazy log<cr>", { desc = "Lazy log" })
vim.keymap.set("n", "<leader>lD", "<cmd>Lazy debug<cr>", { desc = "Lazy debug" })

-- Auto-close Lazy window with Ctrl+C
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	callback = function()
		vim.keymap.set("n", "<C-c>", "<cmd>:q<cr>", { buffer = true, desc = "Close Lazy" })
	end,
})

-- ═══════════════════════════════════════════════════════════════════════════
-- ► DIFF MODE
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "su", ":windo diffthis<CR>", { desc = "Enable diff" })
vim.keymap.set("n", "sx", ":windo diffoff<CR>", { desc = "Disable diff" })
vim.keymap.set("n", "sn", "]c", { desc = "Next diff" })
vim.keymap.set("n", "sp", "[c", { desc = "Previous diff" })
vim.keymap.set("n", "st", ":diffput<CR>", { desc = "Diff put" })
vim.keymap.set("n", "sg", ":diffget<CR>", { desc = "Diff get" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► DIRECTORY NAVIGATION
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<F5>", ":pwd<CR>", { desc = "Show current directory" })
vim.keymap.set("n", "<F6>", ":!ls<CR>", { desc = "List files in directory" })
vim.keymap.set("n", "<F7>", ':exec "cd %:h"<CR>', { noremap = true, silent = true, desc = "CD to file directory" })
vim.keymap.set("n", "<F8>", ":cd ..<CR>", { noremap = true, silent = true, desc = "CD to parent directory" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► MARKS & REGISTERS
-- ═══════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<C-F12>", ":marks<CR>", { desc = "Show all marks" })
vim.keymap.set("n", "<C-F11>", ":reg<CR>", { desc = "Show all registers" })
vim.keymap.set("n", "<Leader>lm", ":marks<CR>", { desc = "Show all marks" })
vim.keymap.set("n", "<Leader>lr", ":reg<CR>", { desc = "Show all registers" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► CONFIG RELOAD
-- ═══════════════════════════════════════════════════════════════════════════

-- ACTIVE: Comprehensive reload function (better - reloads lazy cache)
local function reload_config()
	vim.cmd("wall")
	require("lazy.core.cache").reset()
	
	for name, _ in pairs(package.loaded) do
		if name:match("^user%.") or name:match("^core%.") then
			package.loaded[name] = nil
		end
	end
	
	vim.cmd("source $MYVIMRC")
	
	if pcall(require, "which-key") then
		require("which-key").register(require("which-key").plugins)
	end
	vim.notify("Neovim config reloaded!", vim.log.levels.INFO)
end

vim.keymap.set("n", "<F9>", reload_config, { desc = "Reload config (F9)" })

-- ALTERNATIVE: Simple keymap reload (commented - less comprehensive)
-- vim.keymap.set("n", "<leader>r", function()
-- 	local file = vim.fn.stdpath("config") .. "/lua/keymaps.lua"
-- 	dofile(file)
-- 	vim.notify("Keymaps reloaded!", vim.log.levels.INFO)
-- end, { desc = "Reload keymaps.lua" })

-- ═══════════════════════════════════════════════════════════════════════════
-- ► COMMENTED/ARCHIVED CODE (for reference)
-- ═══════════════════════════════════════════════════════════════════════════

-- ► GitSigns integration (disabled - uncomment if using gitsigns)
-- require("gitsigns").setup({
-- 	on_attach = function(bufnr)
-- 		local gs = package.loaded.gitsigns
-- 		local function map(mode, l, r, opts)
-- 			opts = opts or {}
-- 			opts.buffer = bufnr
-- 			vim.keymap.set(mode, l, r, opts)
-- 		end
-- 		map("n", "]c", function()
-- 			if vim.wo.diff then return "]c" end
-- 			vim.schedule(function() gs.next_hunk() end)
-- 			return "<Ignore>"
-- 		end, { expr = true })
-- 		map("n", "[c", function()
-- 			if vim.wo.diff then return "[c" end
-- 			vim.schedule(function() gs.prev_hunk() end)
-- 			return "<Ignore>"
-- 		end, { expr = true })
-- 		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
-- 		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
-- 		map("n", "<leader>hb", gs.toggle_current_line_blame)
-- 	end,
-- })

-- ► Multi-directory telescope search (disabled - requires telescope setup)
-- vim.keymap.set("n", "<leader>fdd", function()
-- 	local directories = {
-- 		"C:/code_data/",
-- 		"E:/Tools/BPY_Scripts/",
-- 		vim.fn.expand("~") .. "/projects/",
-- 	}
-- 	local files = {}
-- 	for _, dir in ipairs(directories) do
-- 		local scanned = scan.scan_dir(dir, { hidden = true, depth = 5 })
-- 		vim.list_extend(files, scanned)
-- 	end
-- 	pickers.new({}, {
-- 		prompt_title = "Search in multiple dirs",
-- 		finder = finders.new_table({ results = files }),
-- 		sorter = conf.file_sorter({}),
-- 		attach_mappings = function(prompt_bufnr, map)
-- 			actions.select_default:replace(function()
-- 				local selection = action_state.get_selected_entry()
-- 				actions.close(prompt_bufnr)
-- 				vim.cmd("edit " .. selection[1])
-- 			end)
-- 			return true
-- 		end,
-- 	}):find()
-- end, { desc = "Multi directory search" })

-- ► Alternative nvim-tree API usage (commented - functional approach)
-- local nvimtree = require('nvim-tree.api')
-- vim.keymap.set('n', '<leader>n', function()
--   nvimtree.tree.toggle()
-- end, { noremap = true, silent = true, desc = "Toggle NvimTree (Lua)" })
-- vim.keymap.set('n', '<leader>nf', function()
--   nvimtree.tree.find_file()
-- end, { noremap = true, silent = true, desc = "Find current file (Lua)" })

-- ═══════════════════════════════════════════════════════════════════════════
-- END OF CORE KEYMAPS
-- ═══════════════════════════════════════════════════════════════════════════
vim.keymap.set("n", "<leader>tp", function()
	vim.cmd("vsplit")
	vim.cmd("term pwsh")
	-- Opóźnienie wysłania klawiszy, aby terminal zdążył się zainicjować
	vim.schedule(function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<C-\><C-n><C-w>=]], true, false, true), "n", false)
	end)
end, { desc = "Open pwsh in vsplit and equalize" })

local M = {}

local SESSION_DIR = "C:/code_data/tmp/"
local SHADA_DIR = "C:/code_data/tmp/"

-- Upewnij się że foldery istnieją
vim.fn.mkdir(SESSION_DIR, "p")
vim.fn.mkdir(SHADA_DIR, "p")

-- Funkcja do znalezienia sesji z największym _N
local function find_latest_session(base_name)
	local max_num = 0
	local latest_file = nil

	for _, file in ipairs(vim.fn.readdir(SESSION_DIR)) do
		local match = file:match("^" .. base_name .. "_(%d+)%.mks$")
		if match then
			local num = tonumber(match)
			if num > max_num then
				max_num = num
				latest_file = file
			end
		end
	end

	return latest_file, max_num
end

-- :Tss <name> - Save session
function M.save_session(name)
	name = name or "default"

	local base_file = SESSION_DIR .. name .. ".mks"
	local final_file = base_file
	local counter = 1

	if vim.fn.filereadable(base_file) == 1 then
		while vim.fn.filereadable(SESSION_DIR .. name .. "_" .. counter .. ".mks") == 1 do
			counter = counter + 1
		end
		final_file = SESSION_DIR .. name .. "_" .. counter .. ".mks"
	end

	-- 1. SHADA najpierw
	local shada_file = SHADA_DIR .. name .. "_" .. counter .. ".shada"
	vim.cmd("wshada! " .. shada_file)

	-- 2. SESSION potem
	vim.cmd("mksession! " .. final_file)

	print("✓ Sesja: " .. vim.fn.fnamemodify(final_file, ":t"))
	print("✓ Shada: " .. vim.fn.fnamemodify(shada_file, ":t"))
end

-- :Trs <name> - Restore session (POPRAutocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets Autocomplete and Snippets AWNA KOLEJNOŚĆ!)
function M.restore_session(name)
	name = name or "default"

	local latest_session, num = find_latest_session(name)

	if not latest_session then
		local base_file = name .. ".mks"
		if vim.fn.filereadable(SESSION_DIR .. base_file) == 1 then
			latest_session = base_file
			num = 0
		else
			print("✗ Nie znaleziono sesji: " .. name)
			return
		end
	end

	local shada_file = SHADA_DIR .. name .. "_" .. num .. ".shada"

	-- KRYTYCZNA ZMIANA: SHADA PRZED SESSION!
	-- 1. Wczytaj SHADA najpierw (rejestry, historia, marki)
	if vim.fn.filereadable(shada_file) == 1 then
		vim.cmd("rshada! " .. shada_file)
		print("✓ Wczytano shada: " .. vim.fn.fnamemodify(shada_file, ":t"))
	end

	-- 2. SESSION potem (okna, buffery, CWD)
	vim.cmd("source " .. SESSION_DIR .. latest_session)
	print("✓ Przywrócono sesję: " .. latest_session)
end

-- Komendy
vim.api.nvim_create_user_command("Tss", function(opts)
	M.save_session(opts.args)
end, { nargs = "?", desc = "Save session with auto-increment" })

vim.api.nvim_create_user_command("Trs", function(opts)
	M.restore_session(opts.args)
end, { nargs = "?", desc = "Restore latest session" })

-- Keymaps
vim.keymap.set("n", "<A-F5>", function()
	M.save_session("quick")
end, { desc = "Quick save session" })

vim.keymap.set("n", "<A-F6>", function()
	M.restore_session("quick")
end, { desc = "Quick restore session" })

-- -- AUTO-SAVE przy wyjściu
-- vim.api.nvim_create_autocmd("VimLeavePre", {
-- 	callback = function()
-- 		M.save_session("auto")
-- 	end,
-- })

return M

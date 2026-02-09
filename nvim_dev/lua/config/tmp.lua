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

-- load session module
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
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


  
-- new1 keymaps
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

--[[
FLOAT FOCUS / FLOAT OPACITY MANAGER

Cel:
- Ujednolica wygląd floating windows
- Zwiększa fokus przez przyciemnienie tła
- Działa tylko dla zainstalowanych pluginów
- Zero crashy, zero warunków wyścigu

Obsługiwane pluginy:
- Global float (NormalFloat)
- Telescope.nvim
- CopilotChat.nvim
- lazy.nvim

Konfiguracja:
- opacity_percent: 0–100
  0   = brak przezroczystości
  20  = sensowny fokus (rekomendowane)
  40+ = agresywne, męczące
--]]

local M = {}

-----------------------------------------------------------------------
-- KONFIGURACJA
-----------------------------------------------------------------------
M.opacity_percent = 10

-----------------------------------------------------------------------
-- UTILS
-----------------------------------------------------------------------
local function is_installed(name)
	local ok, _ = pcall(require, name)
	return ok
end

local function clamp(v, min, max)
	return math.max(min, math.min(max, v))
end

local function opacity_to_winblend(percent)
	percent = clamp(percent, 0, 100)
	return math.floor((percent / 100) * 30)
end

-----------------------------------------------------------------------
-- APPLY GLOBAL FLOAT STYLE
-----------------------------------------------------------------------
local function apply_global_float()
	local wb = opacity_to_winblend(M.opacity_percent)
	vim.opt.winblend = wb
	vim.opt.pumblend = wb
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0b0e14" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5c6370", bg = "#0b0e14" })
end

-----------------------------------------------------------------------
-- TELESCOPE
-----------------------------------------------------------------------
local function apply_telescope()
	if not is_installed("telescope") then
		return
	end

	local bg = "#080a10"
	local groups = {
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
	}

	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = bg })
	end
end

-----------------------------------------------------------------------
-- COPILOT CHAT
-----------------------------------------------------------------------
local function apply_copilot_chat()
	if not is_installed("CopilotChat") then
		return
	end

	vim.api.nvim_create_autocmd("WinNew", {
		callback = function()
			local win = vim.api.nvim_get_current_win()
			local cfg = vim.api.nvim_win_get_config(win)

			if cfg.relative == "" then
				return
			end

			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

			if ft ~= "copilot-chat" then
				return
			end

			-- Wyłącz transparency dla CopilotChat (lepiej widoczne)
			vim.api.nvim_win_set_option(win, "winblend", 0)

			-- Bazowa opacity + 20%
			local copilot_opacity = math.min(M.opacity_percent + 20, 100)
			vim.api.nvim_win_set_option(win, "winblend", opacity_to_winblend(copilot_opacity))

			vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = "#080a10" })
			vim.api.nvim_set_hl(0, "CopilotChatBackground", { bg = "#080a10" })
			vim.api.nvim_set_hl(0, "CopilotChatBorder", { bg = "#080a10", fg = "#5c6370" })
		end,
	})
end

-----------------------------------------------------------------------
-- LAZY.NVIM
-----------------------------------------------------------------------
local function apply_lazy()
	if not is_installed("lazy") then
		return
	end
	vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#05070c" })
end

-----------------------------------------------------------------------
-- INIT
-----------------------------------------------------------------------
function M.setup(opts)
	opts = opts or {}
	if opts.opacity then
		M.opacity_percent = opts.opacity
	end

	apply_global_float()
	apply_telescope()
	apply_copilot_chat()
	apply_lazy()
end

-----------------------------------------------------------------------
-- AUTO START
-----------------------------------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		M.setup()
		vim.api.nvim_set_hl(0, "LazyNormal", { link = "TelescopeNormal" })
		vim.api.nvim_set_hl(0, "LazyBorder", { link = "TelescopeBorder" })
	end,
})

vim.api.nvim_set_hl(0, "LazyNormal", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "LazyBorder", { link = "TelescopeBorder" })

M.setup()
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰A

-- pro code executor
-- -- ════════════════════════════════════════════════════════════════════════════
-- ENHANCED LUA CODE EXECUTOR WITH PRINT CAPTURE
-- ════════════════════════════════════════════════════════════════════════════ ────────────────────────────────────────────────────────────────────────────
-- Helper: Capture print() output
-- ────────────────────────────────────────────────────────────────────────────
local function capture_prints(func)
  local output = {}
  local old_print = print
  
  -- Override print to capture output
  print = function(...)
    local args = {...}
    local str_parts = {}
    for i, v in ipairs(args) do
      table.insert(str_parts, tostring(v))
    end
    table.insert(output, table.concat(str_parts, "\t"))
  end
  
  -- Execute function
  local results = {pcall(func)}
  local success = table.remove(results, 1)
  
  -- Restore original print
  print = old_print
  
  return success, results, output
end

-- ────────────────────────────────────────────────────────────────────────────
-- Helper: Get visual selection text
-- ────────────────────────────────────────────────────────────────────────────
local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]
  
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
  
  -- Handle partial line selection
  if #lines > 0 then
    local start_col = start_pos[3] - 1
    local end_col = end_pos[3]
    
    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_col + 1, end_col)
    else
      lines[1] = string.sub(lines[1], start_col + 1)
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end
  end
  
  return table.concat(lines, "\n"), end_line
end

-- ────────────────────────────────────────────────────────────────────────────
-- Main: Execute Lua code
-- ────────────────────────────────────────────────────────────────────────────
function M.execute_lua()
  local code, insert_line = get_visual_selection()
  
  if code == "" then
    vim.notify("No code selected", vim.log.levels.WARN)
    return
  end
  
  -- Try to load and execute code
  local func, load_err = load(code, "visual selection", "t", _G)
  
  if not func then
    -- Syntax error
    local output = {
      "",
      "-- ✗ Syntax Error:",
      "-- " .. load_err,
      ""
    }
    vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, output)
    vim.notify("Syntax error in Lua code", vim.log.levels.ERROR)
    return
  end
  
  -- Execute with print capture
  local success, results, prints = capture_prints(func)
  
  -- Build output
  local output = { "" }
  
  if #prints > 0 then
    table.insert(output, "-- Output:")
    for _, line in ipairs(prints) do
      table.insert(output, "-- " .. line)
    end
  end
  
  if not success then
    -- Runtime error
    table.insert(output, "-- ✗ Runtime Error:")
    table.insert(output, "-- " .. tostring(results[1]))
  elseif #results > 0 and results[1] ~= nil then
    -- Return values
    if #prints > 0 then
      table.insert(output, "--")
    end
    table.insert(output, "-- Return:")
    local result_str = vim.inspect(results)
    for line in result_str:gmatch("[^\n]+") do
      table.insert(output, "-- " .. line)
    end
  end
  
  table.insert(output, "")
  
  -- Insert output below selection
  vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, output)
  
  -- Move cursor to output
  vim.api.nvim_win_set_cursor(0, {insert_line + 1, 0})
end

-- ────────────────────────────────────────────────────────────────────────────
-- Feature: Execute and replace selection with result
-- ────────────────────────────────────────────────────────────────────────────
function M.execute_and_replace()
  local code, end_line = get_visual_selection()
  local start_line = vim.fn.getpos("'<")[2] - 1
  
  if code == "" then
    vim.notify("No code selected", vim.log.levels.WARN)
    return
  end
  
  local func, load_err = load("return " .. code, "eval", "t", _G)
  
  if not func then
    -- Try without 'return' prefix
    func, load_err = load(code, "eval", "t", _G)
  end
  
  if not func then
    vim.notify("Cannot evaluate: " .. load_err, vim.log.levels.ERROR)
    return
  end
  
  local success, results, prints = capture_prints(func)
  
  if not success then
    vim.notify("Error: " .. tostring(results[1]), vim.log.levels.ERROR)
    return
  end
  
  -- Replace selection with result
  local result = results[1] or ""
  local result_str = type(result) == "table" and vim.inspect(result) or tostring(result)
  local result_lines = vim.split(result_str, "\n")
  
  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, result_lines)
end

-- ────────────────────────────────────────────────────────────────────────────
-- Feature: Execute in scratch buffer (safe testing)
-- ────────────────────────────────────────────────────────────────────────────
function M.execute_in_scratch()
  local code, _ = get_visual_selection()
  
  if code == "" then
    vim.notify("No code selected", vim.log.levels.WARN)
    return
  end
  
  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'lua')
  
  -- Open in split
  vim.cmd('split')
  vim.api.nvim_win_set_buf(0, buf)
  
  -- Insert code
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(code, "\n"))
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"", "-- ════════════════════════════════════════", ""})
  
  -- Execute
  local func, load_err = load(code, "scratch", "t", _G)
  
  if not func then
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"-- ✗ Syntax Error:", "-- " .. load_err})
    return
  end
  
  local success, results, prints = capture_prints(func)
  
  if #prints > 0 then
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"-- Output:"})
    for _, line in ipairs(prints) do
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"-- " .. line})
    end
  end
  
  if not success then
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"", "-- ✗ Error:", "-- " .. tostring(results[1])})
  elseif #results > 0 and results[1] ~= nil then
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"", "-- Return:"})
    for line in vim.inspect(results):gmatch("[^\n]+") do
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"-- " .. line})
    end
  end
end

-- ────────────────────────────────────────────────────────────────────────────
-- Feature: Quick math/expression eval
-- ────────────────────────────────────────────────────────────────────────────
function M.quick_calc()
  local code, end_line = get_visual_selection()
  local start_line = vim.fn.getpos("'<")[2] - 1
  
  if code == "" then
    vim.notify("No expression selected", vim.log.levels.WARN)
    return
  end
  
  -- Try to evaluate as expression
  local func, _ = load("return " .. code, "calc", "t", _G)
  
  if not func then
    vim.notify("Invalid expression", vim.log.levels.ERROR)
    return
  end
  
  local success, result = pcall(func)
  
  if not success then
    vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
    return
  end
  
  -- Append result as comment
  local result_line = "-- = " .. tostring(result)
  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, {result_line})
end

-- ────────────────────────────────────────────────────────────────────────────
-- Setup keymaps
-- ────────────────────────────────────────────────────────────────────────────
function M.setup()
  -- .ec - Execute code and insert output below
  vim.keymap.set('v', '.ec', M.execute_lua, {
    desc = "Execute Lua code (insert output)"
  })
  
  -- .er - Execute and Replace selection with result
  vim.keymap.set('v', '.er', M.execute_and_replace, {
    desc = "Execute and Replace with result"
  })
  
  -- .es - Execute in Scratch buffer (safe)
  vim.keymap.set('v', '.es', M.execute_in_scratch, {
    desc = "Execute in scratch buffer"
  })
  
  -- .eq - Quick calculator (math eval)
  vim.keymap.set('v', '.eq', M.quick_calc, {
    desc = "Quick calculator"
  })
  
  vim.notify("Lua executor loaded", vim.log.levels.INFO)
end


print("hello")

-- ✗ Syntax Error:
-- [string "visual selection"]:1: '=' expected near '<eof>'


-- ✗ Syntax Error:
-- [string "visual selection"]:1: '=' expected near 'print'


-- Output:
-- hello

-- Output:
-- hello
-- Toggle floating Telescope window
vim.keymap.set('n', '<leader>tf', function()
  -- Check if Telescope floating window is open
  local wins = vim.api.nvim_list_wins()
  local telescope_open = false
  
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'TelescopePrompt' then
      telescope_open = true
      vim.api.nvim_win_close(win, true)
      break
    end
  end
  
  -- If not open, open Telescope
  if not telescope_open then
    require('telescope.builtin').find_files({
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_height = 0.6,
      },
    })
  end
end, { desc = "Toggle Telescope floating" })




return M




-- new keymaps
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

vim.opt.updatetime = 5000 -- czas w milisekunda dla atuozapisu cursor hold po tym czasie mozna robic auto-save


-- messages to new buffer
vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    
    -- Tworzymy nowy bufor bezpośrednio (bez przełączania okna od razu)
    local buf = vim.api.nvim_create_buf(false, true) -- listed: false, scratch: true
    
    -- Rozbijamy tekst i wstawiamy do bufora
    local lines = vim.split(messages, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Otwieramy bufor w nowym oknie (np. dolny split o wysokości 10 linii)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Opcjonalne: Ustawienie kursora na samym dole, by widzieć najnowsze logi
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
end, { desc = 'Messages to scratch buffer' })



-- new keymaps
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

vim.opt.updatetime = 5000 -- czas w milisekunda dla atuozapisu cursor hold po tym czasie mozna robic auto-save


-- messages to new buffer
vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    
    -- Tworzymy nowy bufor bezpośrednio (bez przełączania okna od razu)
    local buf = vim.api.nvim_create_buf(false, true) -- listed: false, scratch: true
    
    -- Rozbijamy tekst i wstawiamy do bufora
    local lines = vim.split(messages, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Otwieramy bufor w nowym oknie (np. dolny split o wysokości 10 linii)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Opcjonalne: Ustawienie kursora na samym dole, by widzieć najnowsze logi
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
end, { desc = 'Messages to scratch buffer' })

-- new keymaps
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

vim.opt.updatetime = 5000 -- czas w milisekunda dla atuozapisu cursor hold po tym czasie mozna robic auto-save


-- messages to new buffer
vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    
    -- Tworzymy nowy bufor bezpośrednio (bez przełączania okna od razu)
    local buf = vim.api.nvim_create_buf(false, true) -- listed: false, scratch: true
    
    -- Rozbijamy tekst i wstawiamy do bufora
    local lines = vim.split(messages, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Otwieramy bufor w nowym oknie (np. dolny split o wysokości 10 linii)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Opcjonalne: Ustawienie kursora na samym dole, by widzieć najnowsze logi
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
end, { desc = 'Messages to scratch buffer' })

-- new keymaps
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

vim.opt.updatetime = 5000 -- czas w milisekunda dla atuozapisu cursor hold po tym czasie mozna robic auto-save


-- messages to new buffer
vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    
    -- Tworzymy nowy bufor bezpośrednio (bez przełączania okna od razu)
    local buf = vim.api.nvim_create_buf(false, true) -- listed: false, scratch: true
    
    -- Rozbijamy tekst i wstawiamy do bufora
    local lines = vim.split(messages, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Otwieramy bufor w nowym oknie (np. dolny split o wysokości 10 linii)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Opcjonalne: Ustawienie kursora na samym dole, by widzieć najnowsze logi
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
end, { desc = 'Messages to scratch buffer' })


-- ================================================================
-- SCRATCHPAD - Szybki notatnik w Neovim
-- ================================================================
-- Otwiera plik scratch.txt w osobnym oknie do szybkich notatek.
-- Plik jest automatycznie zapisywany przy każdej zmianie bufora.
-- ================================================================
local M = {}

--- Ścieżka do folderu przechowującego pliki scratch
--- vim.fn.stdpath("data") zwraca ~/.local/share/nvim (Linux)
--- lub ~/AppData/Local/nvim-data (Windows)
local scratch_dir = vim.fn.stdpath("data") .. "/scratch"

--- Ścieżka do głównego pliku scratchpad
local scratch_path = scratch_dir .. "/scratch.txt" -- BŁĄD: było "scratch_patch"

--- Otwiera okno scratchpad z automatycznym zapisem
---
--- Funkcja:
--- 1. Tworzy folder jeśli nie istnieje
--- 2. Otwiera plik w dolnym splicie (horizontal)
--- 3. Ustawia opcje bufora (brak swap, ukryj po zamknięciu)
--- 4. Dodaje autocmd do automatycznego zapisu
---
--- @return nil
local function open_scratch()
	-- Sprawdź czy folder istnieje, jeśli nie - stwórz go
	-- vim.fn.isdirectory() zwraca 0 (false) jeśli folder nie istnieje
	if vim.fn.isdirectory(scratch_dir) == 0 then
		-- "p" = twórz parent directories (jak mkdir -p)
		vim.fn.mkdir(scratch_dir, "p")
	end

	-- Otwórz plik w nowym splicie
	-- botright = na dole ekranu
	-- split = horizontal split (zmień na "vsplit" dla vertical)
	vim.cmd("botright split " .. scratch_path)

	-- === OPCJE BUFORA (vim.opt_local) ===

	-- bufhidden = "hide"
	-- Buffer nie jest usuwany gdy zamkniesz okno, tylko ukryty
	-- Dzięki temu nie tracisz zmian i historii undo
	vim.opt_local.bufhidden = "hide"

	-- swapfile = false
	-- Wyłącz plik .swp dla tego bufora (nie jest potrzebny)
	vim.opt_local.swapfile = false

	-- buftype = "nofile" (OPCJONALNE - zakomentowane)
	-- Oznacza buffer jako "nie-plik" - nie będzie pytał o zapis
	-- vim.opt_local.buftype = "nofile"

	-- filetype = "markdown" (OPCJONALNE)
	-- Ustaw typ pliku dla syntax highlighting
	-- vim.opt_local.filetype = "markdown"

	-- === AUTO-SAVE PRZY ZMIANIE BUFORA ===

	-- Tworzy autocmd który zapisze plik przy określonych zdarzeniach
	-- buffer = 0 oznacza "obecny buffer" (tylko dla tego scratch)
	vim.api.nvim_create_autocmd(
		{ "CursorHold", "BufLeave", "FocusLost" }, -- eventy
		{
			buffer = 0, -- tylko dla tego bufora
			command = "silent! write", -- zapisz bez błędów
			desc = "Auto-save scratchpad", -- opis (widoczny w :autocmd)
		}
	)

	-- WYJAŚNIENIE EVENTÓW:
	-- - CursorHold: po 'updatetime' ms bez ruchu (domyślnie 4000ms)
	--   Zmień: vim.opt.updatetime = 1000 (1 sekunda)
	-- - BufLeave: gdy przełączasz się na inny buffer
	-- - FocusLost: gdy Neovim traci focus (Alt+Tab, itp.)

	-- UWAGA: było "commnad" zamiast "command" (typo)
end

-- === REJESTRACJA KOMENDY :Scratch ===

-- vim.api.nvim_create_user_command tworzy custom komendę
-- BŁĄD w oryginalnym kodzie: użyto nvim_create_autocmd zamiast nvim_create_user_command
vim.api.nvim_create_user_command(
	"Scratch", -- nazwa komendy
	open_scratch, -- funkcja do wywołania (bez nawiasów!)
	{
		desc = "Open scratchpad file", -- opis (widoczny w :command Scratch)
	}
)
return M
-- === ALTERNATYWNY KEYMAP (OPCJONALNIE) ===

-- Możesz też dodać skrót klawiszowy:
-- vim.keymap.set("n", "<leader>s", open_scratch, { desc = "Open Scratchpad" })

-- ================================================================
-- USAGE / UŻYCIE
-- ================================================================
--
-- 1. Otwórz scratchpad:
--    :Scratch
--    lub <leader>s (jeśli dodasz keymap)
--
-- 2. Pisz notatki - plik zapisze się automatycznie
--
-- 3. Zamknij okno: :q lub :close
--    Buffer pozostaje w tle (bufhidden = "hide")
--
-- 4. Otwórz ponownie: :Scratch
--    Wrócisz do tego samego pliku z historią zmian
--
-- ================================================================
-- IMPROVEMENTS / ULEPSZENIA
-- ================================================================
--
-- 1. TOGGLE ZAMIAST OTWÓRZ:
--    Jeśli okno już istnieje - zamknij je
--
--    local function toggle_scratch()
--    	for _, win in ipairs(vim.api.nvim_list_wins()) do
--    		local buf = vim.api.nvim_win_get_buf(win)
--    		local name = vim.api.nvim_buf_get_name(buf)
--    		if name:match("scratch%.txt$") then
--    			vim.api.nvim_win_close(win, false)
--    			return
--    		end
--    	end
--    	open_scratch()
--    end
--
-- 3. LEPSZY AUTO-SAVE:
--    Zapisuj tylko jeśli buffer został zmodyfikowany
--
--    vim.api.nvim_create_autocmd({ "CursorHold", "BufLeave" }, {
--    	buffer = 0,
--    	callback = function()
--    		if vim.bo.modified then
--    			vim.cmd("silent! write")
--    		end
--    	end,
--    })
--
-- 4. FLOATING WINDOW:
--    Zamiast split, otwórz floating window (bardziej fancy)
--
--    local buf = vim.api.nvim_create_buf(false, true)
--    local width = math.floor(vim.o.columns * 0.8)
--    local height = math.floor(vim.o.lines * 0.8)
--    vim.api.nvim_open_win(buf, true, {
--    	relative = "editor",
--    	width = width,
--    	height = height,
--    	col = math.floor((vim.o.columns - width) / 2),
--    	row = math.floor((vim.o.lines - height) / 2),
--    	style = "minimal",
--    	border = "rounded",
--    })
--    vim.cmd("edit " .. scratch_path)  -- załaduj plik
--
-- 5. DATA/CZAS NA GÓRZE:
--    Automatycznie dodaj datę/czas na początku
--
--    local date = os.date("%Y-%m-%d %H:%M:%S")
--    vim.api.nvim_buf_set_lines(buf, 0, 0, false, {"--- " .. date .. " ---", ""})
--
-- ================================================================
-- ZNALEZIONE BŁĘDY W ORYGINALNYM KODZIE
-- ================================================================
--
-- ❌ BŁĄD 1: scratch_patch -> scratch_path (typo w nazwie zmiennej)
-- ❌ BŁĄD 2: commnad -> command (typo w parametrze autocmd)
-- ❌ BŁĄD 3: nvim_create_autocmd użyty do tworzenia komendy
--            Powinno być: nvim_create_user_command
-- ❌ BŁĄD 4: open_scratch() z nawiasami w rejestracji komendy
--            Powinno być: open_scratch (bez nawiasów - przekaż funkcję)
-- ❌ BŁĄD 5: Pusty obiekt {} jako trzeci argument nvim_create_autocmd
--            To niepoprawne API - powinno być nvim_create_user_command
--
-- ================================================================

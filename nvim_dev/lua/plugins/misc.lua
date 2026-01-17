--- @usage: Konfiguracja automatycznego zapisu plików.
--- Głównym celem jest uniknięcie zaśmiecania "Undo Tree" poprzez:
--- 1. Wyłączenie zapisu przy zdarzeniu TextChanged (zapis po każdej literze).
--- 2. Użycie FocusLost i BufLeave (zapis tylko przy zmianie kontekstu).
--- 3. Ustawienie długiego debounce_delay (3 sekundy), co grupuje zmiany.
--- 4. Zapewnienie, że undofile jest zawsze aktywne.
return {
	{
		"Pocco81/auto-save.nvim",
		event = "BufReadPost",
		config = function()
			require("auto-save").setup({
				enabled = true,

				execution_message = {
					message = function()
						return ("AutoSave: zapisano o " .. vim.fn.strftime("%H:%M:%S"))
					end,
					dim = 0.18,
					cleaning_interval = 1250,
				},

				-- Główne wyzwalacze zapisu
				-- FocusLost: gdy klikasz poza terminal / zmieniasz okno w systemie
				-- BufLeave: gdy przełączasz się między plikami wewnątrz Neovim
				trigger_events = {
					"BufLeave",
					"FocusLost",
				},

				-- Warunki zapisu
				conditions = {
					exists = true,
					filename_is_not = {},
					filetype_is_not = { "gitcommit", "oil", "harpoon" },
					-- Funkcja sprawdzająca, czy nie jesteśmy w trybie Insert
					-- Zapobiega to przerwaniu pisania przez nagły zapis
					not_in_modes = { "i" },
				},

				-- Kluczowe ustawienie dla UNDO:
				-- Czeka 3 sekundy po ostatniej zmianie, zanim spróbuje zapisać.
				-- Dzięki temu seria szybkich zmian zostanie potraktowana jako jeden blok.
				debounce_delay = 3000,

				write_all_buffers = false, -- Tylko aktywny plik

				callbacks = {
					-- Zapewnia, że historia undo jest zapisywana na dysku
					before_save = function()
						vim.opt.undofile = true
					end,
					-- Opcjonalnie: formatowanie przed zapisem (jeśli używasz)
					-- after_save = nil,
				},
			})
		end,
	},
}

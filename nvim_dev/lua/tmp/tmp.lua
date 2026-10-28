local scratch_dir = vim.fn.stdpath("data") .. "/scratch"
local scratch_path = scratch_dir .. "/scratch.txt"

_G.as = function(cmd)
	vim.fn.mkdir(scratch_dir, "p")
	local output = vim.api.nvim_exec2(cmd, { output = true }).output
	local file = io.open(scratch_path, "a")
	if file then
		file:write("\n----------------------------------------\n" .. output .. "\n")
		file:close()
	end
end

--- Uruchamia komendę Neovim i kopiuje jej wynik do rejestru `1`.
--- Prototyp: zapisuje wynik również do schowka rejestru numbered register.
--- Przykład: :RunCopy1 echo "lol"
_G.Cp = function(cmd)
	-- Wykonaj komendę Neovim i pobierz jej wynik.
	local ok, result = pcall(vim.api.nvim_exec2, cmd, {
		output = true,
	})

	if not ok then
		vim.notify(result, vim.log.levels.ERROR)
		return
	end

	-- Kopiuj wynik do rejestru 1.
	vim.fn.setreg("1", result.output)

	-- Pokaż wynik.
	print(result.output)
end

-- Komenda pozostaje:
vim.api.nvim_create_user_command("Cp", function(opts)
	_G.Cp(opts.args)
end, {
	nargs = "+",
	desc = "Execute Neovim Ex command and copy output to register 1",
})

-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

-- Najprościej: dodaj funkcję, która uruchomi skrypt PowerShell 7,
-- przechwyci output i wklei go do Twojego scratchpad.

-- 1. W pliku Lua, w którym masz funkcję _G.Cp, dodaj:

_G.PwshAudit = function()
	-- Ścieżka do skryptu audytu Brave.
	local script = [[C:\code_data\pwsh\brave_audit.ps1]]

	-- Uruchom PowerShell 7 i przechwyć standardowe wyjście.
	local output = vim.fn.system({
		"pwsh",
		"-NoProfile",
		"-ExecutionPolicy",
		"Bypass",
		"-File",
		script,
	})

	-- Sprawdź kod zakończenia skryptu.
	if vim.v.shell_error ~= 0 then
		vim.notify(output, vim.log.levels.ERROR)
		return
	end

	-- Otwórz scratchpad.
	vim.cmd("Scratch")

	-- Pobierz bufor aktualnego okna.
	local buf = vim.api.nvim_get_current_buf()

	-- Dopisz wynik na końcu scratch.txt.
	local lines = vim.split(output, "\n", { plain = true })
	vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)

	-- Zapisz scratchpad.
	vim.cmd("silent! write")

	-- Potwierdź wykonanie.
	vim.notify("Audyt Brave: wynik dodany do scratch.txt")
end

-- 2. Dodaj komendę Neovim.
vim.api.nvim_create_user_command("PwshAudit", function()
	_G.PwshAudit()
end, {
	desc = "Uruchom audyt Brave i dopisz wynik do scratchpad",
})

-- 3. Użycie w Neovim:
--
-- :PwshAudit
--
-- Wynik skryptu:
-- C:\code_data\pwsh\brave_audit.ps1
--
-- zostanie dopisany do:
-- stdpath("data") .. "/scratch/scratch.txt"
--
-- UWAGA:
-- Twój moduł Scratch musi być wcześniej załadowany,
-- aby komenda :Scratch była dostępna.
-- ========== PRZEŁĄCZNIK (TOGGLE) WĘZŁÓW LUASNIP ==========
-- ========== PRZEŁĄCZNIK (TOGGLE) WĘZŁÓW LUASNIP ==========
vim.keymap.set("n", "<leader>uh", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle LSP Inlay Hints" })

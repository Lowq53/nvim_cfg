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

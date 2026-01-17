vim.api.nvim_create_user_command("Dev", function()
	local dev_shada = "C:/code_data/tmp/shada/tmp_1.shada"
	local dev_config = "C:/code_data/nvim-dev"
	local dev_session = "C:/code_data/tmp/tmp.mks"

	-- 1. ustaw shadafile (żeby zapisywać do właściwego)
	vim.opt.shadafile = dev_shada

	-- 2. WYCZYŚĆ aktualny stan (opcjonalne, ale polecane)
	vim.cmd("%bwipeout!")

	-- 3. wczytaj shadę
	vim.cmd("rshada " .. dev_shada)

	-- 4. załaduj sesję (bufory / okna)
	vim.cmd("source " .. dev_session)

	print("DEV loaded: shada + session")
end, {})

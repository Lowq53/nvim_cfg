-- starting nieruchomiości
-- Skrót pod <leader>ps (Project Start)
-- launch run nieruchomości
-- Ustawienie pwsh jako domyślnego shella w Neovim (raz a dobrze)

-- Mapowanie klawiszy
vim.keymap.set("n", ".ln", function()
	-- 1. Serwer WWW (PHP) - otwiera się na dole (split)
	-- Używamy 'term' bez parametrów jeśli shell to pwsh,
	-- lub jawnie podajemy komendę:
	vim.cmd("botright split | term php -S localhost:8053 -t public_html")

	-- 2. WebSockets - otwiera się obok (vsplit)
	vim.cmd("vsplit | term php modules/Core/initWebsocketService.php")

	-- 3. Opcjonalnie: Webpack (jeśli chcesz go mieć w nvimie pod ręką)
	-- vim.cmd("split | term npx webpack --mode=development --watch")

	-- Powrót do okna z kodem
	vim.cmd("wincmd p")
end, { desc = "Uruchom projekt Nieruchomości (PHP + Sockets)" })

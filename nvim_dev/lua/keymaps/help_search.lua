local M = {}

-- Zaawansowane mapowania do nawigacji po dokumentacji i kodzie
M.setup_navigation = function()
	local set = vim.keymap.set

	-- Szybki help pod kursorem (inteligentny jump)
	set("n", "K", function()
		local cw = vim.fn.expand("<cword>")
		local ok = pcall(vim.cmd, "help " .. cw)
		if not ok then
			print("Brak wpisu w help dla: " .. cw)
		end
	end, { desc = "Smart Help Jump" })

	-- Helpgrep - szukanie w treści dokumentacji (Quickfix)
	-- Użycie: :HelpSearch <fraza>
	vim.api.nvim_create_user_command("HelpSearch", function(opts)
		vim.cmd("silent helpgrep " .. opts.args)
		vim.cmd("copen")
	end, { nargs = 1 })

	-- Live Grep wewnątrz runtimepath (szukanie w kodzie pluginów/rdzenia)
	set("n", "<leader>sp", function()
		require("telescope.builtin").live_grep({
			search_dirs = vim.api.nvim_get_runtime_file("", true),
		})
	end, { desc = "Search in Neovim Plugins/Runtime" })
end

M.setup_navigation()

return M

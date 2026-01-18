-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\config\pwsh.lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ps1",
	callback = function()
		-- Ustaw ścieżkę do .dotfiles
		local dotfiles = vim.fn.expand("$HOME") .. "/.dotfiles/pwsh"

		vim.opt_local.includeexpr = [[substitute(substitute(v:fname, '\$root\\', '', ''), '\\', '/', 'g')]]
		vim.opt_local.suffixesadd = ".ps1"
		vim.opt_local.path = ".,modules," .. dotfiles .. "/modules"
	end,
})

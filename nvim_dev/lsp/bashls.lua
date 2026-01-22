-- ~/.config/nvim/lsp/bashls.lua
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh" },
	root_markers = { ".git" },
}

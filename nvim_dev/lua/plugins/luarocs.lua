return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		enabled = false,
		config = true,
		opts = {
			-- You can list rocks to install here.
			-- Lazy.nvim will automatically install/build them.
			rocks = {
				"fzy",
				"pathlib.nvim",
				-- Add any other rocks your plugins or config depend on
			},
			-- luarocks_build_args = { "--with-lua=/my/path" }, -- Optional: extra options for luarocks build
		},
	},
	-- ... your other plugins, which might now depend on the rocks above
}

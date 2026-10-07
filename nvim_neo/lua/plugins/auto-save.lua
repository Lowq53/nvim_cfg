return {
	--https://github.com/pocco81/auto-save.nvim
	"pocco81/auto-save.nvim",
	event = { "InsertLeave", "TextChanged" },
	lazy = false,
	opts = {
		enabled = true,
		write_all_buffers = false,
		debounce_delay = 5000,
		execution_message = {
			message = function()
				return ("autosave: saved at " .. vim.fn.strftime("%h:%m:%s"))
			end,
			dim = 0.18,
			cleaning_interval = 1250,
		},
		trigger_events = { "InsertLeave" },
		condition = function(buf)
			local fn = vim.fn
			local utils = require("auto-save.utils.data")
			return fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
		end,
	},
	config = function(_, opts)
		require("auto-save").setup(opts)
	end,
}

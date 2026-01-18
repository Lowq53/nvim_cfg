return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({
				check_ts = true, -- treesitter (PRO)
				enable_check_bracket_line = true,
				ignored_next_char = "[%w%.]", -- nie paruj w słowach
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "Search",
					highlight_grey = "Comment",
				},
			})

			-- ============================
			-- VS CODE–LIKE QUOTES BEHAVIOR
			-- ============================

			npairs.add_rules({
				-- "
				Rule('"', '"'):with_move(function(opts)
					return opts.next_char == '"'
				end):with_pair(function(opts)
					return opts.prev_char ~= "\\"
				end),

				-- '
				Rule("'", "'"):with_move(function(opts)
					return opts.next_char == "'"
				end):with_pair(function(opts)
					return opts.prev_char ~= "\\"
				end),
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = function()
			return {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},
}

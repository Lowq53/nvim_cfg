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
					chars = { "{", "[", "(", '"', "'"},
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
npairs.setup({
    check_ts = true, -- opcjonalnie, jeśli używasz treesittera
    -- Twoja reszta configu...
})

-- Dodanie reguły dla < >
npairs.add_rule(Rule("<", ">", {
    -- filetypes = { "html", "javascriptreact", "typescriptreact", "vue", "xml" } 
    -- Możesz ograniczyć to tylko do języków webowych powyżej
}))
			npairs.add_rules({
				-- "
				Rule('"', '"')
				  :with_move(function(opts) return opts.next_char == '"' end)
				  :with_pair(function(opts) return opts.prev_char ~= "\\" end),

				-- '
				Rule("'", "'")
				  :with_move(function(opts) return opts.next_char == "'" end)
				  :with_pair(function(opts) return opts.prev_char ~= "\\" end),
				-- Reguła dla średnika
      Rule(";", ";")
      -- Jeśli następny znak to średnik, nie wstawiaj nowego (with_pair = false)
          :with_pair(function() return false end) -- Nie twórz ;;
          :with_move(function(opts) return opts.next_char == ";" end) -- Przeskakuj
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

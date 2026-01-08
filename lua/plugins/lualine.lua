-- lua/plugins/lualine.lua
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- dla ikon w statusline
		"lewis6991/gitsigns.nvim", -- konieczne do Git info
	},
	config = function()
		-- Natywna floating cmdline (Neovim 0.11+)
		vim.opt.cmdheight = 0 -- linia 0, cmdline floating

		-- Helper: czy buffer jest w repo git
		local function in_git_repo()
			return vim.b.gitsigns_status_dict ~= nil
		end

		-- Funkcja zwracająca status Git dla Lualine
		local function git_statusline()
			local gs = vim.b.gitsigns_status_dict
			if not gs then
				return ""
			end

			local branch = gs.head or "?" -- nazwa bieżącej gałęzi
			local ahead = gs.ahead or 0 -- liczba commitów lokalnych przed origin
			local behind = gs.behind or 0 -- liczba commitów lokalnych za origin
			local added = gs.added or 0 -- liczba dodanych plików w repo (staged/unstaged)
			local changed = gs.changed or 0 -- liczba zmodyfikowanych plików
			local removed = gs.removed or 0 -- liczba usuniętych plików

			local parts = {}

			-- Ikona GitHub + nazwa gałęzi
			table.insert(parts, " " .. branch) --  = branch icon, wygląd standardowy

			-- Commit ahead/behind
			if ahead > 0 then
				table.insert(parts, "↑" .. ahead)
			end -- ↑3 → 3 commity przed origin
			if behind > 0 then
				table.insert(parts, "↓" .. behind)
			end -- ↓1 → 1 commit za origin

			-- Diff (added/changed/removed)
			local diff = {}
			if added > 0 then
				table.insert(diff, "+" .. added)
			end -- +0 → liczba nowych plików
			if changed > 0 then
				table.insert(diff, "~" .. changed)
			end -- ~0 → liczba zmodyfikowanych
			if removed > 0 then
				table.insert(diff, "-" .. removed)
			end -- -0 → liczba usuniętych
			if #diff > 0 then
				table.insert(parts, table.concat(diff, " "))
			end

			return table.concat(parts, " ")
		end

		require("lualine").setup({
			options = {
				globalstatus = false, -- 🔴 statusline per window
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard", "alpha" } },
			},

			sections = {
				-- LEWA: kontekst okna
				lualine_a = {
					{
						"mode",
						fmt = function(s)
							return s:sub(1, 1)
						end, -- pokazuje tylko pierwszą literę trybu
					},
				},

				lualine_b = {
					{ git_statusline, cond = in_git_repo }, -- Git branch + ahead/behind + diff
				},

				lualine_c = {
					{
						"filename",
						path = 1, -- relative path
						symbols = {
							modified = " ●", -- plik zmodyfikowany
							readonly = " ", -- plik tylko do odczytu
						},
					},
				},

				-- PRAWA
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = "E ", warn = "W ", info = "I ", hint = "H " },
					},
				},

				lualine_y = { { "filetype", icon_only = true } },
				lualine_z = { { "location" } },
			},

			inactive_sections = {
				-- minimalny status dla nieaktywnego splitu
				lualine_c = {
					{ "filename", path = 0 },
				},
			},

			extensions = { "lazy", "oil", "quickfix" },
		})
	end,
}

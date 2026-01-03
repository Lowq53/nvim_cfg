-- ============================================================================
-- Quickfix + Telescope integration (clean, reload-safe)
-- Author intent preserved, duplicates removed
-- ============================================================================

local Q = {}

local vks = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
function Q.setup()
	Q.setup_quickfix_mappings()
end

-- ----------------------------------------------------------------------------
-- Internal helper: check if Quickfix window exists
-- ----------------------------------------------------------------------------
local function quickfix_is_open()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return true
		end
	end
	return false
end

-- ----------------------------------------------------------------------------
-- Toggle Quickfix window (single source of truth)
-- ----------------------------------------------------------------------------
function Q.toggle()
	if quickfix_is_open() then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

-- ----------------------------------------------------------------------------
-- Basic Quickfix keymaps
-- ----------------------------------------------------------------------------
function Q.setup_quickfix_mappings()
	--quick fix navigation
	--────────────────────────────────────────────────────────────────────────
	vks("n", "<C-q>j", ":cnext<CR>", { desc = "Następny quickfix" })
	vks("n", "<C-q>k", ":cprev<CR>", { desc = "Poprzedni quickfix" })
	vks("n", "<C-q>h", ":colder<CR>", { desc = "Starsza lista quickfix" })
	vks("n", "<C-q>l", ":cnewer<CR>", { desc = "Nowsza lista quickfix" })
	vks("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Quickfix: Open" })
	vks("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Quickfix: Close" })
	vks("n", "<space>q", Q.toggle, { desc = "Quickfix: Toggle" })

	-- Item navigation (cursor stays centered)
	vks("n", "]q", "<cmd>cnext<cr>zz", { desc = "Quickfix: Next item" })
	vks("n", "[q", "<cmd>cprev<cr>zz", { desc = "Quickfix: Prev item" })

	-- File-wise navigation inside QF
	vks("n", "]Q", "<cmd>cnf<cr>", { desc = "Quickfix: Next file" })
	vks("n", "[Q", "<cmd>cpf<cr>", { desc = "Quickfix: Prev file" })

	-- History navigation
	vks("n", "<leader>qh", "<cmd>chistory<cr>", { desc = "Quickfix: History" })
	vks("n", "<leader>qp", "<cmd>colder<cr>", { desc = "Quickfix: Older(Previous) list" })
	vks("n", "<leader>qn", "<cmd>cnewer<cr>", { desc = "Quickfix: Newer list" })

	-- Clear list (safe)
	vks("n", "<leader>qx", "<cmd>cexpr []<cr>", { desc = "Quickfix: Clear list" })
end

-- ----------------------------------------------------------------------------
-- Telescope → Quickfix (explicit, predictable)
-- ----------------------------------------------------------------------------
function Q.search_and_qf()
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")

	builtin.live_grep({
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		attach_mappings = function(_, map_t)
			-- Send results to Quickfix, keep Telescope open
			map_t("i", "<C-q>", actions.send_to_qf)
			map_t("n", "<C-q>", actions.send_to_qf)
			return true
		end,
	})
end

-- ----------------------------------------------------------------------------
-- Optional user commands (clean aliases)
-- ----------------------------------------------------------------------------
cmd("Qo", function()
	vim.cmd("copen")
end, { desc = "Quickfix: Open" })
cmd("Qc", function()
	vim.cmd("cclose")
end, { desc = "Quickfix: Close" })
cmd("Qn", function()
	vim.cmd("cnext")
end, { desc = "Quickfix: Next item" })
cmd("Qp", function()
	vim.cmd("cprev")
end, { desc = "Quickfix: Prev item" })

return Q

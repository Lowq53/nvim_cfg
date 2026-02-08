-- ═══════════════════════════════════════════════════════════════════════════
-- KEYMAP CONFLICT DETECTOR
-- Automatically detects all keymap conflicts in your Neovim config
-- Usage: :lua require('keymap_audit').run()
-- ═══════════════════════════════════════════════════════════════════════════

local M = {}

-- Color codes for output
local colors = {
	red = "\27[31m",
	yellow = "\27[33m",
	green = "\27[32m",
	blue = "\27[34m",
	magenta = "\27[35m",
	cyan = "\27[36m",
	reset = "\27[0m",
}

-- ═══════════════════════════════════════════════════════════════════════════
-- SCAN ALL KEYMAPS
-- ═══════════════════════════════════════════════════════════════════════════
local function get_all_keymaps()
	local modes = { "n", "i", "v", "x", "s", "o", "c", "t" }
	local all_maps = {}

	for _, mode in ipairs(modes) do
		local maps = vim.api.nvim_get_keymap(mode)
		for _, map in ipairs(maps) do
			local key = map.lhs
			if not all_maps[mode] then
				all_maps[mode] = {}
			end
			if not all_maps[mode][key] then
				all_maps[mode][key] = {}
			end
			table.insert(all_maps[mode][key], {
				rhs = map.rhs or "<function>",
				desc = map.desc or "No description",
				buffer = map.buffer,
				callback = map.callback,
			})
		end
	end

	return all_maps
end

-- ═══════════════════════════════════════════════════════════════════════════
-- DETECT CONFLICTS
-- ═══════════════════════════════════════════════════════════════════════════
local function detect_conflicts(all_maps)
	local conflicts = {}

	for mode, keys in pairs(all_maps) do
		for key, mappings in pairs(keys) do
			if #mappings > 1 then
				if not conflicts[mode] then
					conflicts[mode] = {}
				end
				conflicts[mode][key] = mappings
			end
		end
	end

	return conflicts
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PRIORITY KEYS TO CHECK
-- ═══════════════════════════════════════════════════════════════════════════
local priority_keys = {
	["<C-l>"] = "Navigation vs Completion vs Preview",
	["<C-h>"] = "Navigation vs Completion vs Preview",
	["<C-j>"] = "Navigation vs Snippet Jump",
	["<C-k>"] = "Navigation vs Snippet Jump",
	["<Tab>"] = "Completion vs Snippet",
	["<S-Tab>"] = "Completion vs Snippet",
	["<C-n>"] = "Completion vs Choice",
	["<C-p>"] = "Completion vs Choice",
}

-- ═══════════════════════════════════════════════════════════════════════════
-- FORMAT OUTPUT
-- ═══════════════════════════════════════════════════════════════════════════
local function print_conflicts(conflicts)
	print(colors.cyan .. "═══════════════════════════════════════════════════════════════" .. colors.reset)
	print(colors.cyan .. "           KEYMAP CONFLICT REPORT" .. colors.reset)
	print(colors.cyan .. "═══════════════════════════════════════════════════════════════" .. colors.reset)
	print("")

	-- Priority conflicts first
	print(colors.red .. "🚨 HIGH PRIORITY CONFLICTS 🚨" .. colors.reset)
	print("")

	local found_priority = false
	for mode, keys in pairs(conflicts) do
		for key, mappings in pairs(keys) do
			if priority_keys[key] then
				found_priority = true
				print(colors.yellow .. "❌ " .. key .. " in [" .. mode .. "] mode" .. colors.reset)
				print(colors.magenta .. "   Issue: " .. priority_keys[key] .. colors.reset)
				print(colors.blue .. "   Found " .. #mappings .. " mappings:" .. colors.reset)
				for i, map in ipairs(mappings) do
					local rhs = map.rhs
					if type(rhs) == "function" or rhs == "<function>" then
						rhs = colors.green .. "<function>" .. colors.reset
					end
					print(string.format("   %d. %s → %s", i, map.desc or "No desc", rhs))
					if map.buffer then
						print(colors.yellow .. "      (buffer-local)" .. colors.reset)
					end
				end
				print("")
			end
		end
	end

	if not found_priority then
		print(colors.green .. "✓ No high-priority conflicts detected!" .. colors.reset)
		print("")
	end

	-- Other conflicts
	print(colors.yellow .. "⚠️  OTHER CONFLICTS ⚠️" .. colors.reset)
	print("")

	local found_other = false
	for mode, keys in pairs(conflicts) do
		for key, mappings in pairs(keys) do
			if not priority_keys[key] then
				found_other = true
				print(colors.yellow .. "⚠ " .. key .. " in [" .. mode .. "] mode" .. colors.reset)
				print(colors.blue .. "   Found " .. #mappings .. " mappings:" .. colors.reset)
				for i, map in ipairs(mappings) do
					local rhs = map.rhs
					if type(rhs) == "function" or rhs == "<function>" then
						rhs = colors.green .. "<function>" .. colors.reset
					end
					print(string.format("   %d. %s → %s", i, map.desc or "No desc", rhs))
				end
				print("")
			end
		end
	end

	if not found_other then
		print(colors.green .. "✓ No other conflicts detected!" .. colors.reset)
	end

	print(colors.cyan .. "═══════════════════════════════════════════════════════════════" .. colors.reset)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EXPORT TO FILE
-- ═══════════════════════════════════════════════════════════════════════════
local function export_to_file(conflicts, filepath)
	local file = io.open(filepath, "w")
	if not file then
		print("Failed to open file: " .. filepath)
		return
	end

	file:write("# KEYMAP CONFLICT REPORT\n")
	file:write("Generated: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n")

	file:write("## HIGH PRIORITY CONFLICTS\n\n")
	for mode, keys in pairs(conflicts) do
		for key, mappings in pairs(keys) do
			if priority_keys[key] then
				file:write("### " .. key .. " in [" .. mode .. "] mode\n")
				file:write("**Issue:** " .. priority_keys[key] .. "\n")
				file:write("**Mappings found:** " .. #mappings .. "\n\n")
				for i, map in ipairs(mappings) do
					file:write(string.format("%d. %s → %s\n", i, map.desc or "No desc", map.rhs))
				end
				file:write("\n")
			end
		end
	end

	file:write("## OTHER CONFLICTS\n\n")
	for mode, keys in pairs(conflicts) do
		for key, mappings in pairs(keys) do
			if not priority_keys[key] then
				file:write("### " .. key .. " in [" .. mode .. "] mode\n")
				file:write("**Mappings found:** " .. #mappings .. "\n\n")
				for i, map in ipairs(mappings) do
					file:write(string.format("%d. %s → %s\n", i, map.desc or "No desc", map.rhs))
				end
				file:write("\n")
			end
		end
	end

	file:close()
	print(colors.green .. "✓ Report exported to: " .. filepath .. colors.reset)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- MAIN RUN FUNCTION
-- ═══════════════════════════════════════════════════════════════════════════
function M.run(opts)
	opts = opts or {}
	local all_maps = get_all_keymaps()
	local conflicts = detect_conflicts(all_maps)

	print_conflicts(conflicts)

	if opts.export then
		local filepath = opts.export
		export_to_file(conflicts, filepath)
	end

	return conflicts
end

-- ═══════════════════════════════════════════════════════════════════════════
-- USER COMMAND
-- ═══════════════════════════════════════════════════════════════════════════
vim.api.nvim_create_user_command("KeymapAudit", function(args)
	local opts = {}
	if args.args ~= "" then
		opts.export = args.args
	end
	M.run(opts)
end, {
	nargs = "?",
	desc = "Run keymap conflict detection (optional: filepath to export)",
})

return M

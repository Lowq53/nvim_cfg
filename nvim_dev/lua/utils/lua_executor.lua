-- ═══════════════════════════════════════════════════════════════════
-- LUA CODE EXECUTOR
-- ═══════════════════════════════════════════════════════════════════

local M = {}

---@param func function
---@return boolean, table, table
local function capture_prints(func)
  local output = {}
  local old_print = print

  print = function(...)
    local args = {...}
    local str_parts = {}
    for _, v in ipairs(args) do
      table.insert(str_parts, tostring(v))
    end
    table.insert(output, table.concat(str_parts, "\t"))
  end

  local results = {pcall(func)}
  local success = table.remove(results, 1)

  print = old_print

  return success, results, output
end

---@return string, number
local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]

  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

  if #lines > 0 then
    local start_col = start_pos[3] - 1
    local end_col = end_pos[3]

    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_col + 1, end_col)
    else
      lines[1] = string.sub(lines[1], start_col + 1)
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end
  end

  return table.concat(lines, "\n"), end_line
end

function M.execute_lua()
  local code, insert_line = get_visual_selection()

  if code == "" then
    vim.notify("No code selected", vim.log.levels.WARN)
    return
  end

  local func, load_err = load(code, "visual selection", "t", _G)

  if not func then
    local output = { "", "-- ✗ Syntax Error:", "-- " .. load_err, "" }
    vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, output)
    return
  end

  local success, results, prints = capture_prints(func)
  local output = { "" }

  if #prints > 0 then
    table.insert(output, "-- Output:")
    for _, line in ipairs(prints) do
      table.insert(output, "-- " .. line)
    end
  end

  if not success then
    table.insert(output, "-- ✗ Runtime Error:")
    table.insert(output, "-- " .. tostring(results[1]))
  elseif #results > 0 and results[1] ~= nil then
    if #prints > 0 then table.insert(output, "--") end
    table.insert(output, "-- Return:")
    for line in vim.inspect(results):gmatch("[^\n]+") do
      table.insert(output, "-- " .. line)
    end
  end

  table.insert(output, "")
  vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, output)
  vim.api.nvim_win_set_cursor(0, {insert_line + 1, 0})
end

function M.execute_and_replace()
  local code, end_line = get_visual_selection()
  local start_line = vim.fn.getpos("'<")[2] - 1

  if code == "" then
    vim.notify("No code selected", vim.log.levels.WARN)
    return
  end

  local func, _ = load("return " .. code, "eval", "t", _G)
  if not func then
    func, _ = load(code, "eval", "t", _G)
  end

  if not func then
    vim.notify("Cannot evaluate", vim.log.levels.ERROR)
    return
  end

  local success, results, _ = capture_prints(func)

  if not success then
    vim.notify("Error: " .. tostring(results[1]), vim.log.levels.ERROR)
    return
  end

  local result = results[1] or ""
  local result_str = type(result) == "table" and vim.inspect(result) or tostring(result)
  local result_lines = vim.split(result_str, "\n")

  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, result_lines)
end

function M.quick_calc()
  local code, end_line = get_visual_selection()

  if code == "" then
    vim.notify("No expression selected", vim.log.levels.WARN)
    return
  end

  local func, _ = load("return " .. code, "calc", "t", _G)

  if not func then
    vim.notify("Invalid expression", vim.log.levels.ERROR)
    return
  end

  local success, result = pcall(func)

  if not success then
    vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, {"-- = " .. tostring(result)})
end

function M.setup()
  vim.keymap.set('v', '.ec', M.execute_lua, { desc = "Execute Lua code" })
  vim.keymap.set('v', '.er', M.execute_and_replace, { desc = "Execute and Replace" })
  vim.keymap.set('v', '.eq', M.quick_calc, { desc = "Quick calculator" })
end

return M

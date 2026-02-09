-- ═══════════════════════════════════════════════════════════════════
-- SESSION MANAGER MODULE
-- ═══════════════════════════════════════════════════════════════════

local M = {}

local SESSION_DIR = vim.fn.stdpath("data") .. "/sessions/"
local SHADA_DIR = vim.fn.stdpath("data") .. "/shada/"

-- Upewnij się, że katalogi istnieją
vim.fn.mkdir(SESSION_DIR, "p")
vim.fn.mkdir(SHADA_DIR, "p")

---@param name string
---@return string|nil, number
local function find_latest_session(name)
  local counter = 1
  local latest = nil
  
  while vim.fn.filereadable(SESSION_DIR .. name .. "_" .. counter .. ".mks") == 1 do
    latest = name .. "_" .. counter .. ".mks"
    counter = counter + 1
  end
  
  return latest, counter - 1
end

---@param name? string
function M.save_session(name)
  name = name or "default"

  local base_file = SESSION_DIR .. name .. ".mks"
  local final_file = base_file
  local counter = 1

  if vim.fn.filereadable(base_file) == 1 then
    while vim.fn.filereadable(SESSION_DIR .. name .. "_" .. counter .. ".mks") == 1 do
      counter = counter + 1
    end
    final_file = SESSION_DIR .. name .. "_" .. counter .. ".mks"
  end

  -- 1. SHADA najpierw
  local shada_file = SHADA_DIR .. name .. "_" .. counter .. ".shada"
  vim.cmd("wshada! " .. shada_file)

  -- 2. SESSION potem
  vim.cmd("mksession! " .. final_file)

  vim.notify("✓ Sesja: " .. vim.fn.fnamemodify(final_file, ":t"), vim.log.levels.INFO)
  vim.notify("✓ Shada: " .. vim.fn.fnamemodify(shada_file, ":t"), vim.log.levels.INFO)
end

---@param name? string
function M.restore_session(name)
  name = name or "default"

  local latest_session, num = find_latest_session(name)

  if not latest_session then
    local base_file = name .. ".mks"
    if vim.fn.filereadable(SESSION_DIR .. base_file) == 1 then
      latest_session = base_file
      num = 0
    else
      vim.notify("✗ Nie znaleziono sesji: " .. name, vim.log.levels.ERROR)
      return
    end
  end

  local shada_file = SHADA_DIR .. name .. "_" .. num .. ".shada"

  -- 1. SHADA najpierw
  if vim.fn.filereadable(shada_file) == 1 then
    vim.cmd("rshada! " .. shada_file)
    vim.notify("✓ Wczytano shada: " .. vim.fn.fnamemodify(shada_file, ":t"), vim.log.levels.INFO)
  end

  -- 2. SESSION potem
  vim.cmd("source " .. SESSION_DIR .. latest_session)
  vim.notify("✓ Przywrócono sesję: " .. latest_session, vim.log.levels.INFO)
end

function M.setup()
  -- Komendy
  vim.api.nvim_create_user_command("Tss", function(opts)
    M.save_session(opts.args ~= "" and opts.args or nil)
  end, { nargs = "?", desc = "Save session with auto-increment" })

  vim.api.nvim_create_user_command("Trs", function(opts)
    M.restore_session(opts.args ~= "" and opts.args or nil)
  end, { nargs = "?", desc = "Restore latest session" })

  -- Keymaps
  vim.keymap.set("n", "<A-F5>", function()
    M.save_session("quick")
  end, { desc = "Quick save session" })

  vim.keymap.set("n", "<A-F6>", function()
    M.restore_session("quick")
  end, { desc = "Quick restore session" })
end

return M

-- ═══════════════════════════════════════════════════════════════════
-- FLOAT FOCUS / OPACITY MANAGER
-- ═══════════════════════════════════════════════════════════════════

local M = {}

M.opacity_percent = 10

---@param name string
---@return boolean
local function is_installed(name)
  local ok, _ = pcall(require, name)
  return ok
end

---@param v number
---@param min number
---@param max number
---@return number
local function clamp(v, min, max)
  return math.max(min, math.min(max, v))
end

---@param percent number
---@return number
local function opacity_to_winblend(percent)
  percent = clamp(percent, 0, 100)
  return math.floor((percent / 100) * 30)
end

local function apply_global_float()
  local wb = opacity_to_winblend(M.opacity_percent)
  vim.opt.winblend = wb
  vim.opt.pumblend = wb
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0b0e14" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5c6370", bg = "#0b0e14" })
end

local function apply_telescope()
  if not is_installed("telescope") then return end

  local bg = "#080a10"
  local groups = {
    "TelescopeNormal", "TelescopeBorder",
    "TelescopePromptNormal", "TelescopePromptBorder",
    "TelescopeResultsNormal", "TelescopeResultsBorder",
    "TelescopePreviewNormal", "TelescopePreviewBorder",
  }

  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = bg })
  end
end

local function apply_copilot_chat()
  if not is_installed("CopilotChat") then return end

  vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
      local win = vim.api.nvim_get_current_win()
      local cfg = vim.api.nvim_win_get_config(win)
      if cfg.relative == "" then return end

      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
      if ft ~= "copilot-chat" then return end

      local copilot_opacity = math.min(M.opacity_percent + 20, 100)
      vim.api.nvim_win_set_option(win, "winblend", opacity_to_winblend(copilot_opacity))

      vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = "#080a10" })
      vim.api.nvim_set_hl(0, "CopilotChatBackground", { bg = "#080a10" })
      vim.api.nvim_set_hl(0, "CopilotChatBorder", { bg = "#080a10", fg = "#5c6370" })
    end,
  })
end

local function apply_lazy()
  if not is_installed("lazy") then return end
  vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#05070c" })
  vim.api.nvim_set_hl(0, "LazyNormal", { link = "TelescopeNormal" })
  vim.api.nvim_set_hl(0, "LazyBorder", { link = "TelescopeBorder" })
end

---@param opts? { opacity?: number }
function M.setup(opts)
  opts = opts or {}
  if opts.opacity then
    M.opacity_percent = opts.opacity
  end

  apply_global_float()
  apply_telescope()
  apply_copilot_chat()
  apply_lazy()

  -- Auto-reapply on colorscheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      M.setup({ opacity = M.opacity_percent })
    end,
  })
end

return M

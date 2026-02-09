local M = {}

local modules = {
  "float_focus",
  "help",
  "keymaps",
  "lua_executor",
  "scratch",
  "session",
}

---@param opts? table Opcjonalna konfiguracja dla modułów
function M.setup(opts)
  opts = opts or {}
  
  for _, module_name in ipairs(modules) do
    local full_path = "utils." .. module_name
    local ok, module = pcall(require, full_path)
    
    if ok and type(module.setup) == "function" then
      -- Przekaż opts do modułu (jeśli są)
      local module_opts = opts[module_name] or {}
      
      local setup_ok, err = pcall(module.setup, module_opts)
      if not setup_ok then
        vim.notify(
          string.format("❌ %s: %s", module_name, err),
          vim.log.levels.ERROR
        )
      end
    elseif not ok then
      vim.notify(
        string.format("❌ Missing: %s", full_path),
        vim.log.levels.WARN
      )
    end
  end
end

return M

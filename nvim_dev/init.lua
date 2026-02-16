-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/init.luy
-- ~/.config/nvim/init.lua
-- only require here pls

require("config.settings")
require("config.autocmd")
require("keymaps")
-- new aproach to loading with .setup() as cunction
-- pros: / lazy load / full control / kolejność deterministic / able to confgure / easy debug / best practices
require("utils").setup()

-- all confg.tmp.lua moved to utils
--require("config.tmp")

-- lub jeśli używasz mingw32-make:
require("config.lazy")
--require("config.terminal")

require("config.pwsh")
require("config.ui")
-- vim.g.clipboard = {
--   name = "windows-clipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   paste = {
--     ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--     ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard -Raw",
--   },
--   cache_enabled = 0,
-- }
--


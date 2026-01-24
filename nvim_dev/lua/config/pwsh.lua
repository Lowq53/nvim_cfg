-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\config\pwsh.lua
if vim.fn.executable("pwsh") == 1 then
    vim.opt.shell = "pwsh"
else
    vim.opt.shell = "powershell"
end

-- Ustawienie opcji dla poprawnego działania shella w Neovim
vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
vim.opt.clipboard = "unnamedplus"
-- Windows fixes
-- if vim.fn.has("win32") == 1 then
--   -- cmd.exe musi istnieć i być używalny przez .cmd/.bat (npm, gem, itp.)
--   vim.env.COMSPEC = "C:\\Windows\\System32\\cmd.exe"
--
--   local function add_to_path(dir)
--     local path = vim.env.PATH or ""
--     if not path:lower():find(dir:lower(), 1, true) then
--       vim.env.PATH = dir .. ";" .. path
--     end
--   end
--
--   -- krytyczne dla chcp i masy narzędzi
--   add_to_path("C:\\Windows\\System32")
--   add_to_path("C:\\Windows")
--
--   -- (opcjonalnie) jeśli masz 7-zip tu:
--   -- add_to_path("F:\\Programs\\7-Zip")
-- end
--#region
--


-- wykorzystanie chcp dla masona
if vim.fn.has("win32") == 1 then
    -- 1. Poprawiamy PATH, aby Mason widział systemowe narzędzia (chcp, npm, node)
    local paths_to_add = {
        "C:\\Windows\\System32",
        "C:\\Windows",
        "C:\\Program Files\\PowerShell\\7",
        "C:\\Program Files\\nodejs",
    }

    for _, path in ipairs(paths_to_add) do
        -- Sprawdź czy ścieżka już jest w PATH, jeśli nie - dodaj ją na początek
        if not string.find(vim.env.PATH:lower(), path:lower(), 1, true) then
            vim.env.PATH = path .. ";" .. vim.env.PATH
        end
    end

    -- 2. Ustawiamy pwsh jako domyślny shell (ważne dla Masona i terminala)
    if vim.fn.executable("pwsh") == 1 then
        vim.opt.shell = "pwsh"
        vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
        vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
        vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
        vim.opt.shellquote = ""
        vim.opt.shellxquote = ""
    end
end

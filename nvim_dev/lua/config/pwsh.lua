-- C:/Users/LOWq_53/AppData/Local/nvim_cfg/nvim_dev/lua/config/pwsh.lua

-- Ustawienie opcji dla poprawnego działania shella w Neovim
vim.opt.clipboard = "unnamedplus"

if jit.os == "Windows" then
    -- PATH update (unikamy duplikatów)
    local paths_to_add = {
        "C:/Windows/System32",
        "C:/Windows",
        "C:/Program Files/PowerShell/7",
        "C:/Program Files/nodejs",
    }

    for _, path in ipairs(paths_to_add) do
        if not string.find(vim.env.PATH:lower(), path:lower(), 1, true) then
            vim.env.PATH = path .. ";" .. vim.env.PATH
        end
    end

    -- Ustawienie domyślnego shella
    if vim.fn.executable("pwsh") == 1 then
        vim.opt.shell = "pwsh"
        vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
        vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
        vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
        vim.opt.shellquote = ""
        vim.opt.shellxquote = ""
    elseif vim.fn.executable("powershell") == 1 then
        -- fallback do starszego PowerShell
        vim.opt.shell = "powershell"
    else
        -- jeśli brak PowerShell w systemie
        vim.notify("⚠️ PowerShell not found! Some features (Mason, pwsh LSP) may not work.", vim.log.levels.WARN)
        vim.opt.shell = "cmd.exe"  -- minimal fallback
    end

    -- Mason i Filetype fix
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mason",
        callback = function()
            vim.bo.fileencoding = "utf-8"
            vim.bo.bomb = false
        end,
    })
end

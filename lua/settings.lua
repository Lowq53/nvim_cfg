vim.opt.number = true
-- ignoring case sensivity
vim.opt.ignorecase = true
vim.opt.rnu = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- set transparency 

local groups = { "Normal", "NonText", "NormalFloat", "SignColumn", "NormalNC" }
for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- statusline 
vim.opt.laststatus = 2 -- 3 dla globalnego paska w nowym Nvim

local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>nul"):gsub("\n", "")
  if branch ~= "" then return "  " .. branch .. " " else return "" end
end
vim.opt.statusline = "%f %m %=" .. git_branch() .. " %l:%c"

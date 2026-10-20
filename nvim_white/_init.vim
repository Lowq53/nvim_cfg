-- "  _   _                 _
-- " | \ | | ___  _____   _(_)_ __ ___
-- " |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
-- " | |\  |  __/ (_) \ V /| | | | | | |
-- " |_| \_|\___|\___/ \_/ |_|_| |_| |_|
-- "
-- " by Stephan Raabe (2023)
-- " -----------------------------------------------------

-- Basic settings (converted from Vimscript)
vim.opt.nocompatible = true    -- Not needed in Neovim, but harmless
vim.opt.showmatch = true       -- Show matching brackets
vim.opt.ignorecase = true      -- Case-insensitive search
vim.opt.mouse = "a"           -- Enable mouse in all modes
vim.opt.hlsearch = true       -- Highlight search results
vim.opt.incsearch = true      -- Incremental search
vim.opt.tabstop = 4           -- Tab = 4 spaces
vim.opt.softtabstop = 4       -- Treat 4 spaces as a tab
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.shiftwidth = 4        -- Auto-indent width
vim.opt.autoindent = true     -- Keep indentation
vim.opt.number = true         -- Show line numbers
vim.opt.wildmode = "longest:list" -- Bash-like tab completion
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ttyfast = true        -- Optimize for fast terminals

-- Enable syntax highlighting and filetype plugins
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Transparent background (like your Vimscript `hi` commands)
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", fg = "NONE" })

-- ~/.config/nvim/init.lua
require("core.options")   -- Load core settings first
require("core.keymaps")
require("core.autocmds")
require("plugins")        -- Load plugins.lua

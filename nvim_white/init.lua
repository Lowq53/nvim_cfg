-- "  _   _                 _
-- " | \ | | ___  _____   _(_)_ __ ___
-- " |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
-- " | |\  |  __/ (_) \ V /| | | | | | |
-- " |_| \_|\___|\___/ \_/ |_|_| |_| |_|
-- "
-- " by Stephan Raabe (2023)
-- " -----------------------------------------------------

-- ======= --
vim.g.mapleader = "\\"
vim.g.maplocalleader = ","

vim.opt.termguicolors = true
vim.opt.background = "dark"

require("config.lazy")
require("keymaps")
require("settings")
require("config.ui2")
require("utils.browser")
-- require("plugins")        -- Load plugins.lua
-- ======= --
-- ok hiding cmd line




-- Basic settings (converted from Vimscript)
-- vim.opt.nocompatible = true    -- Not needed in Neovim, but harmless
vim.opt.showmatch = true -- Show matching brackets
vim.opt.incsearch = true -- Incremental search
-- Transparent background (like your Vimscript `hi` commands)

-- require("core.autocmds")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = "NONE" })
vim.cmd("syntax on")
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", fg = "NONE" })
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard
vim.opt.wildmode = "longest:list"   -- Bash-like tab completion
vim.opt.number = true               -- Show line numbers
vim.opt.ttyfast = true              -- Optimize for fast terminals
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.softtabstop = 2             -- Treat 4 spaces as a tab


--vim.opt.tabstop = 4           -- Tab = 4 spaces
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.mouse = "a"       -- Enable mouse in all modes
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.shiftwidth = 2    -- Auto-indent width
vim.opt.autoindent = true -- Keep indentation

-- Enable syntax highlighting and filetype plugins
vim.cmd("filetype plugin indent on")
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "NONE" })


vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "NONE" })


-- ~/.config/nvim/lua/settings.lua
-- Production-grade Neovim settings

-- disaplink builtin functions
--=====================================================
  local disabled_built_ins = {
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
    "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
    "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
    "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit",
  }

--tabulacja
--=====================================================

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2-- Ilość spacji do automatycznego wcięcia (np. przy >>)
  vim.opt.softtabstop = 2-- Ilość spacji przy naciskaniu Tab w trybie insert
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.autoindent = true
   













--=====================================================
  --vim.opt.shadafile = "C:/Users/LOWq_53/AppData/Local/nvim-data/shada/main.shada"
  vim.opt.shada = "'100,<50,s10,h"
  vim.opt.termguicolors = true
  vim.opt.background = "dark"

  local function set_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    for _, group in ipairs({  
      "LineNr", "SignColumn", "EndOfBuffer", "MsgArea",
      "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb"
    }) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end
  

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_transparency,
  })

  _G.toggle_transparency = function()
    _G.transparent_enabled = not _G.transparent_enabled
    local bg = _G.transparent_enabled and "none" or "#1a1b26"
    vim.api.nvim_set_hl(0, "Normal", { bg = bg })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
  end

  vim.keymap.set('n', '<leader>ut', toggle_transparency, { desc = 'Toggle transparency' })

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      local c = {
        nb_colors = "#657573"
      }
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#99cfc7" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#4dddf0", bg = "none", bold = true })     
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#4c706b" })
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = c.nb_colors }) 
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = c.nb_colors }) 
    end,
  })
vim.opt.number = true
  vim.opt.relativenumber = true
  vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})
  vim.g.have_nerd_font = true

  vim.o.mouse = "a"
  vim.o.showmode = false
  vim.o.list = false
  vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
  vim.o.inccommand = "split"
  vim.o.cursorline = true
  vim.o.scrolloff = 10
  vim.o.confirm = true

  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

  vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
  end)

  vim.o.breakindent = true
  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.signcolumn = "yes"
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.splitright = true
  vim.o.splitbelow = true

  vim.opt.mouse = "a"
  vim.opt.clipboard = "unnamedplus"
  vim.opt.swapfile = false
  vim.opt.undofile = true
  vim.opt.updatetime = 300
  vim.opt.timeoutlen = 500

  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true
  vim.opt.termguicolors = true
  vim.opt.showmode = false
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.pumheight = 15

  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.hlsearch = true
  vim.opt.incsearch = true



  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = true
  vim.opt.listchars = {
    tab = "▸ ",
    trail = "·",
    nbsp = "␣",
    extends = "»",
    precedes = "«",
  }

  vim.opt.encoding = "utf-8"
  -- vim.opt.fileencoding = "utf-8"
  vim.opt.autoread = true
  vim.opt.autowrite = true

  vim.opt.lazyredraw = true
  vim.opt.ttyfast = true
  vim.opt.completeopt = { "menuone", "noselect", "noinsert" }


  for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end

  vim.opt.termguicolors = true
  vim.opt.background = "dark"

  local function set_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
  

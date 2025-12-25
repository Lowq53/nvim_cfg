return {

 {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false, -- eksplorator ma być dostępny od startu
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local api = require("nvim-tree.api")

local function my_on_attach(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
   -- 1. Load default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- 2. Custom mappings (h/l navigation + vertical/horizontal splits)
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Node"))
    vim.keymap.set("n", "l", api.node.open.edit,            opts("Open"))
    vim.keymap.set("n", "H", api.tree.collapse_all,         opts("Collapse All"))
    vim.keymap.set("n", "L", api.tree.expand_all,           opts("Expand All"))
    
    -- Splits & Files
    vim.keymap.set("n", "v", api.node.open.vertical,       opts("Open: Vertical Split"))
    vim.keymap.set("n", "s", api.node.open.horizontal,     opts("Open: Horizontal Split"))
    vim.keymap.set("n", "a", api.fs.create,                opts("Create File/Folder"))
  end

      -- ═══════════════════════════════════════════════════════════════
      -- NVIM-TREE SETUP
      -- ═══════════════════════════════════════════════════════════════
      require("nvim-tree").setup({
        on_attach = my_on_attach,
        disable_netrw = true,
        hijack_netrw = true,

        view = {
          width = 34,
          side = "left",
          preserve_window_proportions = true,
        },

        renderer = {
          highlight_git = true,
          highlight_opened_files = "name",
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },

        update_focused_file = {
          enable = true,
          update_root = false,
        },

        filesystem_watchers = {
          enable = true,
        },

        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
        },

       git = {
          enable = true,
          ignore = false,
        },
      })

      -- ═══════════════════════════════════════════════════════════════
      -- KEYMAPS (API, zero string commands)
      -- ═══════════════════════════════════════════════════════════════
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Toggle / focus
      map("n", "<leader>e", api.tree.toggle, vim.tbl_extend("force", opts, {
        desc = "Explorer: Toggle",
      }))

      -- Find current file
      map("n", "<leader>ef", api.tree.find_file, vim.tbl_extend("force", opts, {
        desc = "Explorer: Find current file",
      }))

      -- Refresh
      map("n", "<leader>er", api.tree.reload, vim.tbl_extend("force", opts, {
        desc = "Explorer: Refresh",
      }))

      -- Collapse all
      map("n", "<leader>ec", api.tree.collapse_all, vim.tbl_extend("force", opts, {
        desc = "Explorer: Collapse all",
      }))
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
  },
  "mbbill/undotree",
}

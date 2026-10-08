-- C:\Users\LOWq_53\AppData\Local\nvim-lowq53\lua\plugins\ui.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true, -- <--- Upewnij się, że to jest ustawione na TRUE!
        -- term_colors = true, -- Często pomaga w poprawnym renderowaniu kolorów
        -- ... inne opcje twojego motywu
      })
      vim.cmd.colorscheme "tokyonight"

    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  { "nvim-lua/plenary.nvim" },

  {
    "NvChad/nvim-colorizer.lua",
    -- Opcjonalne: Konfiguracja pluginu
    config = function()
      require("colorizer").setup({
        -- Tutaj możesz dostosować opcje kolorowania
        user_default_options = {
          RGB = true, -- Podświetlaj kolory w formacie RGB (np. rgb(255, 0, 0))
          RRGGBB = true, -- Podświetlaj kolory w formacie HEX (np. #RRGGBB)
          names = false, -- Nie podświetlaj nazw kolorów (np. "red")
          -- Możesz określić typy plików, w których ma działać kolorowanie
          -- filetypes = { "*" }, -- Domyślnie działa we wszystkich plikach
          -- filetypes = { "css", "scss", "html", "lua" }, -- Przykład dla konkretnych typów
        },
        -- Możesz także użyć opcji, które definiują, jak kolory są podświetlane
        -- np. "background", "foreground", "virtualtext"
        -- mode = "background", -- Domyślnie podświetla tło wartości koloru
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Tutaj wywołasz funkcję setup z Lualine
      -- Jeśli twój evil_lualine.lua zwraca tabelę konfiguracji:
      local statusline_cfg = require("styles.evil_lualine")
      require("lualine").setup(statusline_cfg)

      -- Jeśli evil_lualine.lua po prostu ustawia zmienne globalne lub wywołuje setup bezpośrednio (mniej typowe):
      -- require("evil_lualine") -- Po prostu załaduj plik
      -- require("lualine").setup() -- Lualine powinien użyć ustawień z evil_lualine.lua, jeśli tak zostały skonfigurowane
    end,
},
}

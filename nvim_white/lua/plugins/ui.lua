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
  { "nuvic/flexoki-nvim", name = "flexoki" },
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
 
}

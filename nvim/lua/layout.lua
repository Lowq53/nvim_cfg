-- 1. Definiujemy tabelę grup, które mają być przezroczyste
local transparent_groups = {
    "Normal",          -- Tło głównego okna
    "NormalNC",        -- Tło okien nieaktywnych
    "LineNr",          -- Numery linii
    "Folded",          -- Zwinięty kod
    "NonText",         -- Znaki specjalne (np. tyldy na końcu pliku)
    "SpecialKey",      -- Specjalne klawisze
    "VertSplit",       -- Pionowe linie podziału okien
    "SignColumn",      -- Kolumna po lewej (na błędy/git)
    "EndOfBuffer",     -- Tyldy na dole ekranu
    "StatusLine",      -- Pasek statusu
    "StatusLineNC",    -- Pasek statusu nieaktywnego okna
}

-- 2. Funkcja aplikująca przezroczystość
local function apply_transparency()
    for _, group in ipairs(transparent_groups) do
        -- bg = "NONE" mówi Neovimowi, żeby nie rysował tła
        -- ctermbg = "NONE" zapewnia wsparcie dla terminali 256-kolorowych
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
end

-- 3. Uruchom od razu
apply_transparency()

-- 4. PROTIP: Autokomenda (Senior Move)
-- Musisz to dodać, bo załadowanie jakiegokolwiek motywu (nawet wbudowanego)
-- nadpisze Twoje ustawienia. Ta komenda pilnuje, żeby zawsze było przezroczyście.
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_transparency,
})

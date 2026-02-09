-- lua\keymaps\copy&paste.lua
-- ═══════════════════════════════════════════════════════════════════════════
-- ► CLIPBOARD OPERATIONS (VSCode-like)
-- ═══════════════════════════════════════════════════════════════════════════

--- @Note Neovim Power User: Copy & Motions
--- @description Przewodnik po zaawansowanym kopiowaniu, rejestrach i ruchach (motions).
---
--- RUCHY (Motions) DO KOPIOWANIA (Yank):
--- - `yw`        -> Kopiuj słowo od kursora do końca (yank word)
--- - `yiw`       -> Kopiuj całe słowo pod kursorem (inner word)
--- - `y$` / `Y`  -> Kopiuj od kursora do końca linii
--- - `yy`        -> Kopiuj całą bieżącą linię
--- - `yG`        -> Kopiuj wszystko od kursora do końca pliku
--- - `yiq`       -> Kopiuj tekst wewnątrz cudzysłowów (inner quote)
--- - `yip`       -> Kopiuj cały akapit (inner paragraph)
---
--- OBSŁUGA REJESTRÓW (Schowków):
--- W Neovimie każdy schowek ma swój adres. Używamy `"`.
--- - `"+y`       -> Kopiuj do schowka systemowego (Windows/Linux)
--- - `"ay`       -> Kopiuj do dedykowanego schowka 'a'
--- - `"ap`       -> Wklej zawartość schowka 'a'
--- - `"0p`       -> Wklej ostatnio skopiowany tekst (pomija usunięte rzeczy)
---
--- POMOCNE KOMENDY:
--- - `:reg`      -> Wyświetl listę wszystkich schowków (rejestrów)
---
--- @usage Wklej do init.lua dla wygody:
-- vim.opt.clipboard = "unnamedplus" -- Używa schowka systemowego dla każdego 'y'
-- vim.keymap.set('v', '<C-c>', '"+y') -- Tradycyjne Ctrl+C w trybie wizualnym

vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Select all
vim.keymap.set("n", "<C-S-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

--- @Note Neovim Power User: Buffers & Clipboard
--- @description Zarządzanie buforami, automatyzacja schowka i efekty wizualne.
---
--- BUFFERS:
--- - :ls           -> Lista buforów
--- - :bn / :bp     -> Następny / Poprzedni
--- - :bd           -> Zamknij bieżący
--- - ggVG          -> Zaznacz całość
---
--- CLIPBOARD AUTO-SYNC:
--- - vim.opt.clipboard = "unnamedplus" (Synchronizacja z systemem)
---
--- HIGHLIGHT ON YANK:
--- - Automatyczne podświetlenie (blink) po skopiowaniu tekstu.
---
----- Automatyczne kopiowanie do schowka po zaznaczeniu myszką
vim.opt.mouse = 'a'              -- Włącza obsługę myszy
vim.opt.clipboard = 'unnamedplus' -- Łączy schowek Neovima z systemowym
--- @usage Wklej poniższy kod do init.lua:
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end
})

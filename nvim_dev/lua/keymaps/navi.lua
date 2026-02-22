-- AppData\Local\nvim_cfg\nvim_dev\lua\keymaps\navi.lua
--
local vks = vim.keymap.set
--lsp diagnostic
--────────────────────────────────────────────────────────────────────────
vks("n", "[d", vim.diagnostic.goto_prev, { desc = "Poprzednia diagnoza" })
vks("n", "]d", vim.diagnostic.goto_next, { desc = "Następna diagnoza" })
vks("n", "<leader>le", vim.diagnostic.open_float, { desc = "Pokaż diagnozę" })

-- searching navi
--────────────────────────────────────────────────────────────────────────
vks("n", "n", "nzzzv", { desc = "Następne wystąpienie z wyśrodkowaniem" })
vks("n", "N", "Nzzzv", { desc = "Poprzednie wystąpienie z wyśrodkowaniem" })
vks("n", "*", "*zzzv", { desc = "Wyszukaj słowo z wyśrodkowaniem" })
vks("n", "#", "#zzzv", { desc = "Wyszukaj słowo wstecz z wyśrodkowaniem" })

-- vks('t', '<Esc>', [[<C-\><C-n]], { desc = 'Exit terminal mode'})
--────────────────────────────────────────────────────────────────────────
vks({ "i", "v" }, "kj", "<Esc>", { desc = "Exit mode" })

-- Pro Tip: Visual Wrap (Nawigacja)
-- ────────────────────────────────────────────────────────────────────────
-- Standardowo 'j' i 'k' skaczą po liniach logicznych (numerach).
-- Poniższe mapowania sprawiają, że poruszasz się po liniach widocznych (zawiniętych).
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- W init.lua lub pliku konfiguracyjnym
--────────────────────────────────────────────────────────────────────────
vks("n", "<C-h>", "<C-w>h", { desc = "Przejdź do okna lewego" })
vks("n", "<C-j>", "<C-w>j", { desc = "Przejdź do okna dolnego" })
vks("n", "<C-k>", "<C-w>k", { desc = "Przejdź do okna górnego" })
vks("n", "<C-l>", "<C-w>l", { desc = "Przejdź do okna prawego" })

-- bufors changing
--────────────────────────────────────────────────────────────────────────
-- / [b / ]b / zmiana buforó
-- vks("n", "<A-j>", ":bprevious<CR>", { desc = "Poprzedni bufor" })
-- vks("n", "<A-k>", ":bnext<CR>", { desc = "Następny bufor" })
-- site scroling
--────────────────────────────────────────────────────────────────────────
vks("n", "<C-d>", "<C-d>zz", { desc = "Pół strony w dół z wyśrodkowaniem" })
vks("n", "<C-u>", "<C-u>zz", { desc = "Pół strony w górę z wyśrodkowaniem" })



-- console navi
-- ────────────────────────────────────────────────────────────────────────
vks("c", "<C-h>", "<Left>")
vks("c", "<C-j>", "<Down>")
vks("c", "<C-k>", "<Up>")
vks("c", "<C-l>", "<Right>")

-- insert mnode navi
--──────────────────────────────────────────────────────────────────────
-- vks("i", "<C-S-h>", "<Left>", { desc = "W lewo w insert mode" })
-- vks("i", "<C-j>", "<Down>", { desc = "W dół w insert mode" })
-- vks("i", "<C-k>", "<Up>", { desc = "W górę w insert mode" })
-- vks("i", "<C-l>", "<Right>", { desc = "W prawo w insert modee" })
--
-- TEST TAB NEVIGATION SETUP
--▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

-- Szybkie przełączanie tabów wielkimi literami (częsty wzorzec seniora)
-- ────────────────────────────────────────────────────────────────────────
vks("n", "<A-p>", ":tabprevious<CR>", { desc = "Poprzedni tab", silent = true })
vks("n", "<leader>tw", ":tabclose<CR>", { desc = "Closing tab"})
vks('n', '<leader>td', ':tabedit % | vsplit #<CR>', { desc = 'Duplikuj 2 bufory do nowej karty' })
vks("n", "<A-n>", ":tabnext<CR>", { desc = "Następny tab", silent = true })

-- Opcjonalnie: szybkie tworzenie i zamykanie tabów
-- ────────────────────────────────────────────────────────────────────────
vks("n", "<leader>tn", ":tabnew<CR>", { desc = "Nowy tab", silent = true })
vks("n", "<leader>tc", ":tabclose<CR>", { desc = "Zamknij tab" })
vks("n", "<leader>0", ":tablast<CR>", { desc = "Skocz do ostatniego taba", silent = true })

-- Jeśli wolisz zostać przy gt/gT, ale chcesz skróty numeryczne (np. lider + 1):
-- ────────────────────────────────────────────────────────────────────────
-- local wk = require("which-key")
--
-- -- Pętla: ustawia skróty i ukrywa je w menu Which-Key
-- for i = 1, 9 do
--     -- Ustawia fizyczny skrót: Space + cyfra
--     vim.keymap.set("n", "<leader>" .. i, i .. "gt", { silent = true })
--     
--     -- Mówi Which-Key, żeby nie wyświetlał 9 osobnych linii
--     wk.add({
--         { "<leader>" .. i, hidden = true }
--     })
-- end
--
-- -- Dodaje jeden zbiorczy opis pod klawiszem "1"
-- wk.add({
--     { "<leader>1", group = "Tabs switch (1-9)" }
-- })
--▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

-- AppData\Local\nvim_cfg\nvim_dev\lua\keymaps\navi.lua
--lsp diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Poprzednia diagnoza" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Następna diagnoza" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Pokaż diagnozę" })

-- searching navi
vim.keymap.set("n", "n", "nzzzv", { desc = "Następne wystąpienie z wyśrodkowaniem" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Poprzednie wystąpienie z wyśrodkowaniem" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Wyszukaj słowo z wyśrodkowaniem" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Wyszukaj słowo wstecz z wyśrodkowaniem" })

--quick fix navigation
vim.keymap.set({"i", "v"}, "kj", "<Esc>", { desc = "Exit mode" })


-- vim.keymap.set('t', '<Esc>', [[<C-\><C-n]], { desc = 'Exit terminal mode'})
vim.keymap.set("n", "<C-q>j", ":cnext<CR>", { desc = "Następny quickfix" })
vim.keymap.set("n", "<C-q>k", ":cprev<CR>", { desc = "Poprzedni quickfix" })
vim.keymap.set("n", "<C-q>h", ":colder<CR>", { desc = "Starsza lista quickfix" })
vim.keymap.set("n", "<C-q>l", ":cnewer<CR>", { desc = "Nowsza lista quickfix" })

-- W init.lua lub pliku konfiguracyjnym
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Przejdź do okna lewego" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Przejdź do okna dolnego" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Przejdź do okna górnego" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Przejdź do okna prawego" })

-- bufors changing
vim.keymap.set("n", "<A-j>", ":bprevious<CR>", { desc = "Poprzedni bufor" })
vim.keymap.set("n", "<A-k>", ":bnext<CR>", { desc = "Następny bufor" })
-- site scroling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Pół strony w dół z wyśrodkowaniem" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Pół strony w górę z wyśrodkowaniem" })

-- normal mode tab navi
-- vim.keymap.set("n", "<C-S-H>", "gT", { desc = "Poprzednia zakładka" })
-- vim.keymap.set("n", "<C-S-L>", "gt", { desc = "Następna zakładka" })
vim.keymap.set("c", "<C-h>", "<Left>")
-- console navi
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-l>", "<Right>")

-- insert mnode navi
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "W lewo w insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "W dół w insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "W górę w insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "W prawo w insert modee" })




-- Ustawienie leadera na spację
local vim = vim
local vks = vim.keymap.set

-- Simulated second leader with comma
vks("n", ",f", function()
  print("Simulated leader with ','")
end, { desc = "Simulated comma leader" }) -- Zamknięcie funkcji



-- Kopiowanie pełnej ścieżki do schowka
vks('n', '<leader>pa', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { desc = 'Copy full path to clipboard' })

-- Otwieranie pliku ze schowka
vks('n', '<leader>po', function()
  local clipboard_content = vim.fn.getreg('+')
  if clipboard_content and clipboard_content ~= '' then
    vim.cmd('edit ' .. vim.fn.fnameescape(clipboard_content))
  else
    print('Clipboard is empty')
  end
end, { desc = 'Open file from clipboard' })

-- Dodatkowe przydatne vksowania:
vks('n', '<leader>pr', function()
  local path = vim.fn.expand('%:.') -- Relatywna ścieżka
  vim.fn.setreg('+', path)
  print('Copied relative path: ' .. path)
end, { desc = 'Copy relative path to clipboard' })

vks('n', '<leader>pf', function()
  local filename = vim.fn.expand('%:t') -- Tylko nazwa pliku
  vim.fn.setreg('+', filename)
  print('Copied filename: ' .. filename)
end, { desc = 'Copy filename to clipboard' })

vks('n', '<leader>pd', function()
  local dir = vim.fn.expand('%:p:h') -- Katalog pliku
  vim.fn.setreg('+', dir)
  print('Copied directory: ' .. dir)
end, { desc = 'Copy directory to clipboard' })

  vks("n", "<leader>pn", ":set relativenumber!<CR>")




-- Skrót do przeładowania keymaps bez restartu
vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.stdpath("config") .. "/lua/keymaps.lua"
  dofile(file)
  -- Poniższa linia wygląda na duplikat lub błąd w ścieżce, zakładam, że keymaps są w jednym miejscu.
  -- Jeśli masz keymaps w dwóch miejscach i chcesz ładować oba, zostaw to. W przeciwnym razie usuń.
  -- dofile(os.getenv("HOME") .. "/.dotfiles/.config/nvim/lua/keymaps.lua")
  vim.notify("Keymaps reloaded!", vim.log.levels.INFO)
end, { desc = "reload keymaps.lua" })

vim.keymap.set('n', '<leader>v', function() vim.notify('Success!', vim.log.levels.INFO) end, { desc = 'Show success message' })

vim.keymap.set('i', '-0', '<Esc>', { noremap = true, silent = true })

-- naprawic inkrementowanie ctrl a 0
vim.keymap.set({ "n", "v", "i" }, "<M-R-0>", '<Esc>', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Menu-]>", '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', '<leader>k', function()
  print("Naciśnij klawisz...")
  local char = vim.fn.getchar()
  print("Otrzymany kod:", char, "(" .. vim.fn.nr2char(char) .. ")")
end)

-- exc keymap
-- pigeon shortuts - Primegen
-- łaczenie pozwala zeby kursor był w jednym miejscu nie dodaje go na koncu lin
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "<leader>s p", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { noremap = true, silent = false })

vim.keymap.set("n", "C-x>", ":q<CR>")

-- Przenoszenie linii w górę/dół w trybie Normal
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Przenoszenie w trybie Visual
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Podstawowe skróty jak w VSCode:

-- Ctrl+c kopiuje do clipboarda (VSCode copy)
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true }) -- Duplikat leader y (NvimTreeToggle)

-- Wklej z systemowego schowka
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true }) -- Ctrl+v wkleja

-- Zaznacz wszystko (Select All)
vim.keymap.set("n", "<C-S-a>", "ggVG", { noremap = true, silent = true })

-- Zapisz plik (Save)
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Zamknij bufor/zakładkę (Close tab)
vim.keymap.set("n", "<C-ww>", ":bd<CR>", { noremap = true, silent = true })

-- Cofnij (Undo)
-- vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true }) -- Zakomentowane

-- Ponów (Redo)
vim.keymap.set("n", "<C-y>", "<C-r>", { noremap = true, silent = true })

-- Przełącz między buforami (tabs) jak w VSCode Ctrl+Tab / Ctrl+Shift+Tab
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Otwórz wyszukiwanie (Find)
vim.keymap.set("n", "<C-f>", "/", { noremap = true, silent = false })

-- Alt-q: Zamykanie bufora/terminala
vim.keymap.set("n", "<A-q>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("bw!")
  else
    vim.cmd("wq") -- zamyka terminal
  end
end, { noremap = true, silent = true })
-- Usunięto zduplikowane: vim.keymap.set("n", "<A-q>", ":wq!<CR>", { noremap = true, silent = true })

-- Przełączanie do poprzedniego bufora
vim.keymap.set("n", "<C-PageUp>", ":bprevious<CR>", { noremap = true, silent = true })

-- Przełączanie do następnego bufora
vim.keymap.set("n", "<C-PageDown>", ":bnext<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<M-F1>", ":vsplit | terminal<CR>", { desc = "Executed Terminal" })
vim.keymap.set("n", "<C-F2>", "<C-w>v", { desc = "Podziel okno wertykalnie." })
vim.keymap.set("n", "<F5>", ":pwd<CR>", { desc = "Lista plików w bieżącym katalogu" })
vim.keymap.set("n", "<A-F3>", ":bn | !bd #<CR>", { desc = "Executed Terminal" })
vim.keymap.set("n", "<F6>", ":!ls<CR>", { desc = "Lista plików w bieżącym katalogu" })

-- Mapowania klawiszy dla nvim-tree.lua
vim.keymap.set("n", "<leader>y", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" }) -- Duplikat z "+y
vim.keymap.set(
  "n",
  "<leader>yf",
  ":NvimTreeFindFile<CR>",
  { noremap = true, silent = true, desc = "Find current file in NvimTree" }
)
vim.keymap.set("n", "<leader>yr", ":NvimTreeRefresh<CR>", { noremap = true, silent = true, desc = "Refresh NvimTree" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- LSP
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Zmień nazwę" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Akcje kodu" })

-- Lazy.nvim
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy<cr>", { desc = "Otwórz Lazy" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Aktualizuj pluginy" })

-- LSP i lintowanie
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Diagnostyka" })
vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Następny błąd" })
vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Poprzedni błąd" })

-- Logi
vim.keymap.set("n", "<leader>lL", "<cmd>Lazy log<cr>", { desc = "Logi Lazy" })
vim.keymap.set("n", "<leader>lD", "<cmd>Lazy debug<cr>", { desc = "Debug Lazy" })

vim.keymap.set("n", "<F7>", ':exec "cd %:h"<CR>',
  { noremap = true, silent = true, desc = "Zmień katalog na katalog bieżącego pliku" })
vim.keymap.set("n", "<F8>", ":cd ..<CR>", { noremap = true, silent = true, desc = "Zmień katalog na nadrzędny" })

local function reload_config()
  vim.cmd("wall") -- Zapisz wszystkie bufory (opcjonalne)
  require("lazy.core.cache").reset() -- Wyczyść cache Lazy i przeładuj pluginy

  -- Przeładuj moduły konfiguracyjne (np. keymaps.lua, settings.lua)
  for name, _ in pairs(package.loaded) do
    if name:match("^user%.") or name:match("^core%.") then -- Dostosuj do swojej struktury
      package.loaded[name] = nil
    end
  end

  vim.cmd("source $MYVIMRC") -- Przeładuj init.lua

  -- Zaktualizuj which-key (kluczowy krok!)
  if pcall(require, "which-key") then
    require("which-key").register(require("which-key").plugins) -- Wymuś aktualizację
  end
  vim.notify('Reload Neovim config', vim.log.levels.INFO)
end

vim.keymap.set('n', '<F9>', reload_config, { desc = 'Reload config (F9)' })

vim.keymap.set("n", "su", ":windo diffthis<CR>", { desc = "Enable diff" })
vim.keymap.set("n", "sx", ":windo diffoff<CR>", { desc = "Disable diff" })
vim.keymap.set("n", "sn", "]c", { desc = "Next diff" })
vim.keymap.set("n", "sp", "[c", { desc = "Previous diff" })
vim.keymap.set("n", "st", ":diffput<CR>", { desc = "Diff put" })
vim.keymap.set("n", "sg", ":diffget<CR>", { desc = "Diff geta" })

-- Navigacja oknami (domyślne skróty nvim)
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Przejdź do okna górnego (Ctrl+↑)" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Przejdź do okna dolnego (Ctrl+↓)" })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Przejdź do okna lewego (Ctrl+←)" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Przejdź do okna prawego (Ctrl+→)" })

-- Tmux navigator keys (Jeśli używasz nvim-tmux-navigation, te mapowania mogą kolidować z powyższymi C-h/l)
vks("n", "<C-h>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLeft() end, { silent = true })
vks("n", "<C-j>", function() require("nvim-tmux-navigation").NvimTmuxNavigateDown() end, { silent = true })
vks("n", "<C-k>", function() require("nvim-tmux-navigation").NvimTmuxNavigateUp() end, { silent = true })
vks("n", "<C-l>", function() require("nvim-tmux-navigation").NvimTmuxNavigateRight() end, { silent = true })
vks("n", "<C-\\>", function() require("nvim-tmux-navigation").NvimTmuxNavigateLastActive() end, { silent = true })

-- buffor, shortcuts, terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>', { noremap = true })
-- Usunięto zduplikowane: vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Usuń bieżący bufor" })

vim.keymap.set("n", "<A-F2>", "<C-w>v", { desc = "Podziel okno wertykalnie (Alt+F1)" }) -- Alt-F2 w opisie Alt-F1

-- Leader lm - Wyświetl listę wszystkich markerów
-- F12 - Wyświetl listę wszystkich markerów
-- F11 - Wyświetl listę wszystkich rejestrów (z ich zawartością)
vim.keymap.set("n", "<C-F12>", ":marks<CR>", { desc = "Show all marks" })
vim.keymap.set("n", "<C-F11>", ":reg<CR>", { desc = "Show all registers" })
vim.keymap.set("n", "<S-F12>", ":messages<CR>", { desc = "Show all marks" })
vim.keymap.set("n", "<Leader>lm", ":marks<CR>", { desc = "Show all marks" })
vim.keymap.set("n", "<Leader>lr", ":reg<CR>", { desc = "Show all registers" })

-- LSP KEYMAPS
vim.keymap.set("n", "<leader>ls", ":LspStop<CR>", { desc = "[L]SP [S]top (disable LSP for current buffer)" })
vim.keymap.set("n", "<leader>lS", ":LspStart<CR>", { desc = "[L]SP [S]tart (enable LSP again)" })

local lsp_enabled = true -- Domyślnie włączony
function ToggleLSP()
  if lsp_enabled then
    -- Wyłącz wszystkie aktywne LSP
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.notify("LSP wyłączony", vim.log.levels.WARN)
  else
    -- Włącz LSP dla aktualnego bufora (wymaga `nvim-lspconfig`)
    vim.cmd('edit') -- Przeładuj bufor, aby uruchomić LSP
    vim.notify("LSP włączony", vim.log.levels.INFO)
  end
  lsp_enabled = not lsp_enabled
end

-- Mapowanie klawisza (np. <leader>ll)
vim.keymap.set('n', '<leader>ls', ToggleLSP, { desc = '[L]SP Toggle' }) -- Duplikat z :LspStop

-- Globalna funkcja otwierająca zaznaczone słowo (tekst wewnątrz spacji) jako URL
function _G.open_selected_as_url()
  local old_register = vim.fn.getreg('"') -- 1. Zapisz aktualny rejestr

  -- 2. Skopiuj tekst pod kursorem (dla trybu normalnego) lub zaznaczony tekst (dla trybu visual)
  if vim.fn.mode() == 'n' then
    vim.cmd('normal! ya ') -- kopiuj całe "słowo" (w tym znaki specjalne jak /, :, itp)
  -- else -- Ta sekcja jest zakomentowana, więc nie jest używana dla trybu wizualnego
  -- vim.cmd('normal! gv"yy') -- kopiuj aktualny zaznaczony obszar
  end

  local url = vim.fn.getreg('y') -- 3. Pobierz URL
  vim.fn.setreg('"', old_register) -- 4. Przywróć oryginalny rejestr

  -- 5. Dodaj protokół jeśli brak
  if not url:match('^%a+://') then
    url = 'https://' .. url
  end

  -- 6. Otwórz URL
  if vim.fn.has('win32') == 1 then
    vim.fn.system('start "" "' .. url .. '"')
  elseif vim.fn.has('unix') == 1 then
    vim.fn.system('xdg-open "' .. url .. '" &')
  else
    vim.notify('Unsupported system', vim.log.levels.ERROR)
    return
  end

  vim.notify('Otwieram URL: ' .. url, vim.log.levels.INFO) -- 7. Powiadomienie
end

-- Mapowania otwierania URL
vim.keymap.set('n', '<leader>w', '<cmd>lua open_selected_as_url()<CR>', { desc = 'Open URL under cursor' })
vim.keymap.set('v', '<leader>w', '<cmd>lua open_selected_as_url()<CR>', { desc = 'Open selected URL' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Alternatywne keymapy (Tele✨)
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Tele✨: Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Tele✨: Live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Tele✨: Help tags' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Tele✨: Buffers' })

vim.keymap.set('n', '<leader>fp', function()
  builtin.find_files({
    search_dirs = {
      "/home/lowq53/neovim/",
      "/home/lowq53/code_data/",
      vim.fn.expand("~/.config/hypr/"),
      vim.fn.expand("~/code_data/"),
      vim.fn.expand("%:h"),
      vim.fn.expand("~/projects"),
      vim.fn.getcwd(), -- bieżący katalog Neovima
    },
    hidden = true, -- pokazuj ukryte pliki (np. .gitignore)
  })
end, { desc = 'Tele:✨All' })

vim.keymap.set('n', '<leader>sd', function()
  builtin.find_files({
    search_dirs = {
      "/home/lowq53/Downloads/",
    },
    hidden = true,
  })
end, { desc = 'Tele: Down' })

vim.keymap.set('n', '<leader>sx', function()
  builtin.find_files({
    search_dirs = {
      vim.fn.expand("~/.config/hypr/"),
      vim.fn.expand("~/projects"),
      vim.fn.getcwd(), -- bieżący katalog Neovima
    },
    hidden = true, -- pokazuj ukryte pliki (np. .gitignore)
  })
end, { desc = 'Tele:✨All' })

-- vertical help
-- Zawsze otwieraj help w pionowym podziale
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd L")
    end
  end,
}) 

-- Konfiguracja otwierania linków w Brave Browser
-- Możesz dodać to do init.lua lub osobnego pliku konfiguracyjnego

-- 1. PODSTAWOWA KONFIGURACJA - ustaw Brave jako domyślną przeglądarkę
vim.g.netrw_browsex_viewer = "brave"

-- 2. FUNKCJA DO OTWIERANIA LINKÓW
local function open_url_in_brave()
  local url = vim.fn.expand('<cWORD>')  -- pobierz słowo pod kursorem
  
  -- Sprawdź czy to jest URL
  if url:match('^https?://') or url:match('^www%.') then
    local cmd
    
    -- Wykryj system operacyjny
    if vim.fn.has('macunix') == 1 then
      cmd = 'open -a "Brave Browser" ' .. vim.fn.shellescape(url)
    elseif vim.fn.has('unix') == 1 then
      cmd = 'brave-browser ' .. vim.fn.shellescape(url) .. ' &'
      -- Alternatywnie, jeśli brave-browser nie działa:
      -- cmd = 'brave ' .. vim.fn.shellescape(url) .. ' &'
    elseif vim.fn.has('win32') == 1 then
      cmd = 'start brave ' .. vim.fn.shellescape(url)
    end
    
    if cmd then
      vim.fn.system(cmd)
      print('Otwarto w Brave: ' .. url)
    else
      print('Nie można otworzyć URL na tym systemie')
    end
  else
    print('Nie znaleziono prawidłowego URL pod kursorem')
  end
end

-- 3. KEYMAP - otwórz URL pod kursorem (np. gx)
vim.keymap.set('n', 'gx', open_url_in_brave, { desc = 'Otwórz URL w Brave' })

-- 4. KOMENDA DO OTWIERANIA KONKRETNEGO URL
vim.api.nvim_create_user_command('OpenInBrave', function(opts)
  local url = opts.args
  if url == '' then
    print('Podaj URL: :OpenInBrave https://example.com')
    return
  end
  
  local cmd
  if vim.fn.has('macunix') == 1 then
    cmd = 'open -a "Brave Browser" ' .. vim.fn.shellescape(url)
  elseif vim.fn.has('unix') == 1 then
    cmd = 'brave-browser ' .. vim.fn.shellescape(url) .. ' &'
  elseif vim.fn.has('win32') == 1 then
    cmd = 'start brave ' .. vim.fn.shellescape(url)
  end
  
  if cmd then
    vim.fn.system(cmd)
    print('Otwarto w Brave: ' .. url)
  end
end, { nargs = 1, desc = 'Otwórz URL w Brave Browser' })

-- 5. PLUGIN ALTERNATYWA - Możesz też użyć pluginu
--[[
{
  'tyru/open-browser.vim',
  config = function()
    -- Ustaw Brave jako domyślną przeglądarkę
    if vim.fn.has('macunix') == 1 then
      vim.g.openbrowser_browser_commands = {
        { name = 'brave', args = { 'open', '-a', 'Brave Browser' } }
      }
    elseif vim.fn.has('unix') == 1 then
      vim.g.openbrowser_browser_commands = {
        { name = 'brave', args = { 'brave-browser' } }
      }
    elseif vim.fn.has('win32') == 1 then
      vim.g.openbrowser_browser_commands = {
        { name = 'brave', args = { 'brave.exe' } }
      }
    end
    
    -- Keymaps
    vim.keymap.set('n', 'gx', '<Plug>(openbrowser-smart-search)', { desc = 'Otwórz w przeglądarce' })
    vim.keymap.set('v', 'gx', '<Plug>(openbrowser-smart-search)', { desc = 'Otwórz w przeglądarce' })
  end,
}
--]]

-- 6. DODATKOWE FUNKCJE
-- Funkcja do wyszukiwania zaznaczonego tekstu w Google
local function google_search()
  local mode = vim.fn.mode()
  local text
  
  if mode == 'v' or mode == 'V' then
    -- W trybie visual, pobierz zaznaczony tekst
    vim.cmd('normal! "vy')
    text = vim.fn.getreg('v')
  else
    -- W trybie normal, pobierz słowo pod kursorem
    text = vim.fn.expand('<cword>')
  end
  
  if text and text ~= '' then
    local url = 'https://www.google.com/search?q=' .. vim.fn.shellescape(text)
    local cmd
    
    if vim.fn.has('macunix') == 1 then
      cmd = 'open -a "Brave Browser" ' .. url
    elseif vim.fn.has('unix') == 1 then
      cmd = 'brave-browser ' .. url .. ' &'
    elseif vim.fn.has('win32') == 1 then
      cmd = 'start brave ' .. url
    end
    
    if cmd then
      vim.fn.system(cmd)
      print('Wyszukiwanie w Google: ' .. text)
    end
  end
end

-- Keymap dla Google search
vim.keymap.set('n', '<leader>gs', google_search, { desc = 'Google search słowo pod kursorem' })
vim.keymap.set('v', '<leader>gs', google_search, { desc = 'Google search zaznaczony tekst' })

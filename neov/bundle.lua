-- bundle.lua   (uruchom w folderze configu)
--   nvim -l bundle.lua          -> tylko require z init.lua
--   nvim -l bundle.lua review   -> + lua/plugins/*.lua doklejone jako komentarz (do przeglądu, nie do uruchomienia)
local root = vim.uv.cwd()
local mods, out = {}, {}
local missing = {}
local review = arg and arg[1] == "review"

local function read(p)
  local f = assert(io.open(root .. "/" .. p, "rb"))
  local s = f:read("*a"); f:close(); return s
end

local function find(mod)
  local rel = mod:gsub("%.", "/")
  for _, p in ipairs({ "lua/" .. rel .. ".lua", "lua/" .. rel .. "/init.lua" }) do
    if vim.uv.fs_stat(root .. "/" .. p) then return p end
  end
end

-- usuwa komentarze (tylko do skanowania require, do bundla idzie oryginał)
local function strip(src)
  src = src:gsub("%-%-%[(=*)%[.-%]%1%]", "")
  src = src:gsub("%-%-[^\n]*", "")
  return src
end

local scan
local function take(mod)
  if mods[mod] or missing[mod] then return end
  local p = find(mod)
  if not p then missing[mod] = true; return end
  mods[mod] = read(p)
  scan(mods[mod])
end

function scan(src)
  src = strip(src)
  for mod in src:gmatch("require%s*%(?%s*[\"']([%w_%.%-]+)[\"']") do take(mod) end
  for mod in src:gmatch("require%s*,%s*[\"']([%w_%.%-]+)[\"']") do take(mod) end -- pcall(require, "x")
end

local init = read("init.lua")
scan(init)

out[#out + 1] = "-- bundle " .. os.date("%Y-%m-%d %H:%M") .. " from " .. root .. "\n"

local names = vim.tbl_keys(mods)
table.sort(names)
for _, mod in ipairs(names) do
  local src = mods[mod]
  if strip(src):match("^%s*$") then print("WARN pusty modul: " .. mod) end
  out[#out + 1] = ("package.preload[%q] = function(...)\n%s\nend\n"):format(mod, src)
end
out[#out + 1] = init

if review then
  local dir = root .. "/lua/plugins"
  if vim.uv.fs_stat(dir) then
    for name, t in vim.fs.dir(dir) do
      if t == "file" and name:match("%.lua$") then
        out[#out + 1] = ("--[==[ REVIEW ONLY: lua/plugins/%s\n%s\n]==]\n"):format(name, read("lua/plugins/" .. name))
      end
    end
  end
end

local ext = vim.tbl_keys(missing)
table.sort(ext)
if #ext > 0 then print("EXTERNAL (nie w bundlu): " .. table.concat(ext, ", ")) end

local f = assert(io.open(root .. "/out.lua", "wb"))
f:write(table.concat(out, "\n")); f:close()
print("OK: " .. vim.tbl_count(mods) .. " modules -> out.lua")

-- CO POPRAWIŁEM (nazwy root, mods, out, read, find, scan, init zostały):
-- 1) GŁÓWNA PRZYCZYNA martwych modułów: regex łapał require w KOMENTARZACH, stąd config.lazy i config.keymaps
--    w bundlu mimo zakomentowanych require w init.lua. Teraz strip() usuwa komentarze przed skanem
--    (bundel dostaje oryginalny kod z komentarzami). Efekt: config.lazy i config.keymaps znikną z out.lua (poprawnie).
--    Uwaga: "--" wewnątrz stringa (np. "--branch=stable") też jest obcinane, ale tylko w kopii do skanu.
-- 2) Puste moduły (np. commands) -> ostrzeżenie WARN. Zostają w bundlu, bo require nadal ich szuka (pusty plik = OK).
-- 3) Moduły zewnętrzne/pluginy (require "lazy", "telescope"...) -> lista EXTERNAL zamiast cichego pominięcia.
-- 4) Plugins: lazy ładuje lua/plugins przez { import = "plugins" }, nie przez require, więc normalny bundle ich nie łapie.
--    Tryb "review" dokleja lua/plugins/*.lua jako blok komentarza --[==[ ]==] (do wrzucenia mi na analizę, nie do odpalenia).
--    Nie jest rekurencyjny (tylko pliki bezpośrednio w lua/plugins).
-- 5) Kolejność modułów posortowana (pairs() dawał losową -> diff out.lua między uruchomieniami był nieczytelny).
-- 6) Dodany nagłówek z datą i ścieżką (zamiast mylących komentarzy ze starych plików) i wzorzec pcall(require, "x").

-- Pytanie: odpalić na nvim_dev z "review" (tam są prawdziwe pluginy) i wrzucić mi out.lua?

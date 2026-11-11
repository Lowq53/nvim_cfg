-- System clipboard support for Linux.
-- Neovim's + register needs a clipboard provider such as wl-clipboard or xclip.

if vim.fn.has("linux") ~= 1 then
  return
end

local function executable(name)
  return vim.fn.executable(name) == 1
end

local provider
if vim.env.SSH_TTY then
  provider = "osc52"

elseif vim.env.WAYLAND_DISPLAY and executable("wl-copy") and executable("wl-paste") then
  provider = {
    name = "wl-clipboard",
    copy = {
      ["+"] = { "wl-copy", "--type", "text/plain;charset=utf-8" },
      ["*"] = { "wl-copy", "--primary", "--type", "text/plain;charset=utf-8" },
    },
    paste = {
      ["+"] = { "wl-paste", "--no-newline", "--type", "text/plain" },
      ["*"] = { "wl-paste", "--primary", "--no-newline", "--type", "text/plain" },
    },
    cache_enabled = 0,
  }
elseif executable("xclip") then
  provider = {
    name = "xclip",
    copy = {
      ["+"] = { "xclip", "-selection", "clipboard" },
      ["*"] = { "xclip", "-selection", "primary" },
    },
    paste = {
      ["+"] = { "xclip", "-selection", "clipboard", "-o" },
      ["*"] = { "xclip", "-selection", "primary", "-o" },
    },
    cache_enabled = 0,
  }
elseif executable("xsel") then
  provider = {
    name = "xsel",
    copy = {
      ["+"] = { "xsel", "--clipboard", "--input" },
      ["*"] = { "xsel", "--primary", "--input" },
    },
    paste = {
      ["+"] = { "xsel", "--clipboard", "--output" },
      ["*"] = { "xsel", "--primary", "--output" },
    },
    cache_enabled = 0,
  }
end

if provider then
  vim.g.clipboard = provider
  vim.opt.clipboard = "unnamedplus"
else
  vim.schedule(function()
    vim.notify(
      "Nie znaleziono narzędzia schowka systemowego. Zainstaluj wl-clipboard (Wayland), xclip lub xsel (X11).",
      vim.log.levels.WARN
    )
  end)
end

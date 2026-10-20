-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp", -- opcjonalne dla regex support
  dependencies = {
    -- opcjonalne - gotowe snippety
    "rafamadriz/friendly-snippets",
    -- "mireq/luasnip-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    -- Konfiguracja podstawowa
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
    })

    -- 0. Load your custom snippets from ~/.config/nvim/snippets/
require("luasnip.loaders.from_lua").load({
    paths = { "~/.dotfiles/.config/nvim/lua/snippets/" }
  })
    -- Load snippets from different sources
    -- 1. Load friendly-snippets (if installed)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- 2. Load external snippet files (like the GitHub repo you mentioned)
  --require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/external-snippets/lua/luasnip_snippets/"})
    -- You can load specific files like this:
    -- require("luasnip.loaders.from_lua").load({paths = "/path/to/external/snippets/"})
vim.api.nvim_create_user_command("SrcSnippets", function()
    require("luasnip.loaders.from_lua").load({paths = "~/.dotfiles/.config/nvim/lua/snippets/"})
end, { desc = "Reload LuaSnip snippets" })


require("luasnip").filetype_extend("bash", { "all" })

    -- Keybindings
    vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-E>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent = true})
    -- Twoje własne snippety
    ls.add_snippets("all", {
      -- Snippet dla ####
      s("hash4", {
        t("####"),
        t({"", "#"}),
        i(1, "wstawianie tekstu"),
        t({"", "####"})
      }),

      -- Snippet dla #===
      s("hash3eq", {
        t("#===")
      }),
    })

    -- Ładowanie snippetów z friendly-snippets (opcjonalne)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Ładowanie własnych snippetów z plików
  end,
}


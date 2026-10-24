-- C:\Users\LOWq_53\AppData\Local\nvim_cfg\nvim_dev\lua\keymaps\init.lua
-- Załaduj wszystkie moduły klawiszy
--require("keymaps.autocomplete")
--
-- require("keymaps.core")
-- -- BASE
--   core        (zapis, quit, buffery, okna, schowek)
--   clipboard_diff
--   -- NAWIGACJA
--   navi        (ruch, skoki)
--   tmuxnavi
--   quickfix
--   dir_navi    -> do scalenia z "files"
--   -- PLIKI / SZUKANIE
--   files       (telescope, fzf-lua, oil/nvim-tree)
--   help_search
--   -- SESJE / TERMINAL
--   sessions$MY
--   terminal
--   -- GIT / AI / LANG
--   git         (neogit, diffview, gitsigns)
--   ai          (copilotchat, avante)
--   python
--   -- LEADER
--   space, extra -> rozbić: to "worek na resztę", trzymaj puste/małe
--                                                                    --
require("keymaps.core")
require("keymaps.dir_navi")
require("keymaps.extra")
require("keymaps.help_search")
--require("keymaps.init")
require("keymaps.navi")
--require("keymaps.navi_cmd")
require("keymaps.quickfix")
require("keymaps.sessions")
require("keymaps.space")
require("keymaps.terminal")
require("keymaps.tmuxnavi")
require("keymaps.clipboard_diff")
require("keymaps.python")

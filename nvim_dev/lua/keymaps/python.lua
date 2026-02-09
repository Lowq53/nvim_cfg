-- F5: restart Flask server
vim.api.nvim_set_keymap(
  "n", "<c-a-F5>", ":!kill -HUP $(cat /tmp/flask.pid) && python app.py &<CR>", -- komenda shell
  { noremap = true, silent = true }
)

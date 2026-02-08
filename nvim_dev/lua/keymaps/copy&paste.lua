-- lua\keymaps\copy&paste.lua
-- ═══════════════════════════════════════════════════════════════════════════
-- ► CLIPBOARD OPERATIONS (VSCode-like)
-- ═══════════════════════════════════════════════════════════════════════════

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Select all
vim.keymap.set("n", "<C-S-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })


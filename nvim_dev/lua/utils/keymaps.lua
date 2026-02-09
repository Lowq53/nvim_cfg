-- ═══════════════════════════════════════════════════════════════════
-- CUSTOM KEYMAPS
-- ═══════════════════════════════════════════════════════════════════

local M = {}

function M.setup()
  vim.opt.updatetime = 5000

  -- Messages to new buffer (TYLKO RAZ!)
  vim.keymap.set('n', '<leader>mm', function()
    local messages = vim.fn.execute('messages')
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(messages, '\n')
    
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.cmd('split')
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
  end, { desc = 'Messages to scratch buffer' })

  -- Toggle Telescope floating
  vim.keymap.set('n', '<leader>tf', function()
    local wins = vim.api.nvim_list_wins()
    
    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      if ft == 'TelescopePrompt' then
        vim.api.nvim_win_close(win, true)
        return
      end
    end

    require('telescope.builtin').find_files({
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_height = 0.6,
      },
    })
  end, { desc = "Toggle Telescope floating" })
end

return M

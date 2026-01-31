vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local fname = vim.api.nvim_buf_get_name(0)
    local realname = vim.loop.fs_realpath(fname)
    if realname and realname ~= fname then
      vim.api.nvim_buf_set_name(0, realname)
      vim.cmd("edit!")
    end
  end,
})

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

-- auto wyrównanie po owtarciu okna 
vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
        vim.cmd("wincmd =")
    end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ps1",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})

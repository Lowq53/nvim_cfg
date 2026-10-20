return {
  "nvim-lualine/lualine.nvim",  -- Optional dependency
  config = function()
    -- 1. Hide cmdline by default
    vim.opt.cmdheight = 0

    -- 2. Show only during command input
    vim.api.nvim_create_autocmd('CmdlineEnter', {
      callback = function()
        vim.opt.cmdheight = 1
        -- Optional: Minimal lualine for command mode
        if package.loaded['lualine'] then
          require('lualine').setup({ sections = { lualine_a = { 'mode' } } })
        end
      end
    })

    -- 3. Restore when done
    vim.api.nvim_create_autocmd('CmdlineLeave', {
      callback = function()
        vim.opt.cmdheight = 0
        -- Optional: Restore full lualine
        if package.loaded['lualine'] then
          require('lualine').refresh()
        end
      end
    })
  end,
  event = "VeryLazy"  -- Loads automatically when needed
}

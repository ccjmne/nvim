return {
  'stefandtw/quickfix-reflector.vim' ,
  {
    '73/vim-klog',
    config = function()
      vim.cmd('highlight link klogRecord Title')
    end,
  },
  {
    -- lazy.nvim will overrwrite runtimepath: this is the only way to do
    -- that while I'm sticking with lazy.nvim.
    -- TODO: consider dropping lazy.nvim, move this to init.lua.
    dir = '.',
    config = function()
      local localrt = vim.fn.finddir('.vimrt', ';')
      if localrt ~= '' then
        vim.opt.rtp:append(localrt)
        vim.cmd 'runtime! after/ftdetect/*.vim'
        vim.cmd 'runtime! after/ftplugin/*.vim'
        vim.notify('Added ' .. localrt .. ' to runtimepath', vim.log.levels.INFO)
      end
    end,
  }
}

return {
  'stefandtw/quickfix-reflector.vim' ,
  {
    '73/vim-klog',
    config = function()
      vim.cmd('highlight link klogRecord Title')
    end,
  },
  {
    dir = '.',
    config = function()
      local localrt = vim.fn.finddir('.vimrt', ';')
      if localrt ~= '' then
        vim.opt.rtp:append(localrt)
        vim.notify('Added ' .. localrt .. ' to runtimepath', vim.log.levels.INFO)
      end
    end,
  }
}

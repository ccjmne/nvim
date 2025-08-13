return {
  {
    'stefandtw/quickfix-reflector.vim',
    config = function() end,
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

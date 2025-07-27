return {
  {
    'stefandtw/quickfix-reflector.vim',
    config = function() end,
  },
  {
    dir = '.',
    config = function()
      local gitdir = vim.fn.fnamemodify(vim.fn.finddir('.git', '.;') or '', ':p:h')
      local localrt = vim.fn.resolve(gitdir .. '/../.vimrt')
      if vim.fn.isdirectory(localrt) == 1 then
        vim.opt.rtp:append(localrt)
        vim.notify('Added ' .. localrt .. ' to runtimepath', vim.log.levels.INFO)
      end
    end,
  }
}

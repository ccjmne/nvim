return {
  {
    'junegunn/vim-easy-align',
    config = function()
      vim.cmd [[
        nmap ga      <Plug>(EasyAlign)
        vmap <Enter> <Plug>(EasyAlign)
      ]]
    end
  },
  { 'pteroctopus/faster.nvim' },
  { 'MagicDuck/grug-far.nvim' },
}

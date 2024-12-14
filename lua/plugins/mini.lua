return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
    end,
  },
  {
    'echasnovski/mini.surround',
    keys = { 'sa', 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' },
    config = function()
      require('mini.surround').setup()
    end,
  },
}

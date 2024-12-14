return {
  {
    'ntpeters/vim-better-whitespace', -- Can't be VeryLazy
    init = function()
      vim.g.show_spaces_that_precede_tabs = 1
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
          delay = 0,
          chars = { right_arrow = '─' },
          style = {
            '#806d9c',
            '#c21f30',
          },
        },
        indent = {
          enable = true,
        },
      }
    end
  },
}

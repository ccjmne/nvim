return {
  {
    'ntpeters/vim-better-whitespace', -- Can't be VeryLazy
    init = function()
      vim.g.show_spaces_that_precede_tabs = 1
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      local iscope = require 'mini.indentscope'
      iscope.setup {
        draw = {
          delay = 0,
          animation = iscope.gen_animation.none(),
        },
        options = {
          try_as_border = true,
          border = 'both',
          indent_at_cursor = false, },
        symbol = '▏',
      }
    end,
  },
}

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function() vim.cmd.colorscheme 'catppuccin' end,
  opts = {
    -- Use colors.none to revert something's colour
    -- See available colours at: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
    custom_highlights = function(colors)
      -- C = require('catppuccin.palettes').get_palette 'mocha'
      -- U = require 'catppuccin.utils.colors'
      return {
        LineNr = { fg = colors.overlay0 },
        LineNrAbove = { fg = colors.overlay0 },
        LineNrBelow = { fg = colors.overlay0 },
        NonText = { fg = colors.mantle, bg = colors.text },
        ExtraWhitespace = { fg = colors.surface0, bg = colors.red },
        Whitespace = { fg = colors.surface0 },
        MiniStatuslineInactive = { fg = colors.overlay2 },
      }
    end,
    show_end_of_buffer = true,
    integrations = {
      copilot_vim = true,
      dap = true,
      dap_ui = true,
      fzf = true,
      gitgutter = true,
    },
  },
}

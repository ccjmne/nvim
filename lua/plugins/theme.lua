-- Blocky window separators
vim.opt.fillchars:append({ vert = "█", horiz = "█", horizup = "█", horizdown = "█", vertleft = "█", vertright = "█", verthoriz = "█" })
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local statusline_nc = vim.api.nvim_get_hl(0, { name = 'StatusLineNC', link = false })
    if statusline_nc and statusline_nc.bg then
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = statusline_nc.bg })
    end
    -- The baked-in treesitter highlighting for vimdoc's ================= delimiter lines perturbs me
    vim.api.nvim_set_hl(0, '@markup.heading.1.delimiter.vimdoc', { link = '@markup' })
    vim.api.nvim_set_hl(0, '@markup.heading.2.delimiter.vimdoc', { link = '@markup' })

    vim.api.nvim_set_hl(0, 'CursorColumn', { link = 'CursorLine' })
  end,
})

vim.api.nvim_set_hl(0, '@text.bold', { bold = true })
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
        MiniIndentscopeSymbol = { fg = colors.overlay0 },
        ExtraWhitespace = { fg = colors.surface0, bg = colors.red },
        Whitespace = { fg = colors.surface2 },
        MiniStatuslineInactive = { fg = colors.overlay2 },
        SpellBad = { style = { 'underline' } },
        SpellCap = { style = { 'underline' } },
        SpellRare = { style = { 'underline' } },
        SpellLocal = { style = { 'underline' } },
        ['@yellow.bold'] = { fg = colors.yellow, bold = true }, -- or style = { 'bold' }
        ['@teal.bold'] = { fg = colors.teal, bold = true },
        ['@green.bold'] = { fg = colors.green, bold = true },
        ['@red.bold'] = { fg = colors.red, bold = true },
        ['@blue.bold'] = { fg = colors.blue, bold = true },
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

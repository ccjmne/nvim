vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'CursorColumn', { link = 'CursorLine' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = vim.api.nvim_get_hl(0, { name = 'StatusLineNC', link = false }).bg })
    vim.api.nvim_set_hl(0, '@markup.heading.1.delimiter.vimdoc', { link = '@markup' }) -- fix disturbing treesitter vimdoc highlighting
    vim.api.nvim_set_hl(0, '@markup.heading.2.delimiter.vimdoc', { link = '@markup' })
  end,
})

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function() vim.cmd.colorscheme 'catppuccin' end,
  opts = {
    custom_highlights = function(colors)
      return {
        LineNr = { fg = colors.overlay0 },
        LineNrAbove = { fg = colors.overlay0 },
        LineNrBelow = { fg = colors.overlay0 },
        ExtraWhitespace = { fg = colors.surface0, bg = colors.red },
        Whitespace = { fg = colors.surface2 },
        ['@tag'] = { fg = colors.lavender }, -- xml
        ['@yellow.bold'] = { fg = colors.yellow, bold = true }, -- or style = { 'bold' }
        ['@teal.bold'] = { fg = colors.teal, bold = true },
        ['@green.bold'] = { fg = colors.green, bold = true },
        ['@red.bold'] = { fg = colors.red, bold = true },
        ['@blue.bold'] = { fg = colors.blue, bold = true },
        ['@text.bold'] = { bold = true },
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

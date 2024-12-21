return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<Leader>ff', function() require 'fzf-lua'.files {} end,                                        desc = '[F]ind [F]iles' },
    { '<Leader>fn', function() require 'fzf-lua'.files { cwd = vim.fn.stdpath 'config' } end,         desc = '[F]ind in [N]eovim Config' },
    { '<Leader>fm', function() require 'fzf-lua'.files { cwd = vim.env.HOME .. '/git/dotfiles' } end, desc = '[F]ind in [M]y Dotfiles' },
  },
}

return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<Leader>ff', function() require 'fzf-lua'.files {} end, desc = '[F]ind [F]iles' },
  },
}

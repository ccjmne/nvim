return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<Leader>sf', function() require('fzf-lua').files() end, desc = 'Search Files in CWD' },
  },
}

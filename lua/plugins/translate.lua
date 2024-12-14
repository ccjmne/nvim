return {
  'uga-rosa/translate.nvim',
  cmd = 'Translate',
  keys = { { '<Leader>tr', '<CMD>Translate en<CR>', mode = { 'n', 'v' }, desc = 'Translate selection to English' } },
  config = {
    default = {
      command = 'google',
      output = 'replace',
    },
  },
}

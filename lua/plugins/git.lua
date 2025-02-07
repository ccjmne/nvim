return {
  {
    'airblade/vim-gitgutter',
    lazy = false,
    init = function()
      vim.g.gitgutter_preview_win_floating = 0
      vim.g.gitgutter_highlight_linenrs = 1
      vim.g.gitgutter_signs = 0
      vim.g.gitgutter_grep = 'rg'
      vim.api.nvim_set_hl(0, 'GitGutterAddLineNr', { link = 'GitGutterAdd' })
      vim.api.nvim_set_hl(0, 'GitGutterChangeLineNr', { link = 'GitGutterChange' })
      vim.api.nvim_set_hl(0, 'GitGutterDeleteLineNr', { link = 'GitGutterDelete' })
      vim.api.nvim_set_hl(0, 'GitGutterChangeDeleteLineNr', { link = 'GitGutterChangeDelete' })
    end,
  },
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'git' },
        callback = function()
          vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })
        end,
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'fugitiveblame', 'fugitive' },
        callback = function()
          -- in fugitiveblame, gq (unlike <CMD>q<CR>) jumps back to the current work-tree version
          vim.keymap.set('n', 'q', 'gq', { buffer = 0, remap = true })
        end,
      })
    end,
  },
  {
    'rbong/vim-flog',
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = { 'tpope/vim-fugitive' },
    init = function()
      vim.g.flog_permanent_default_opts = { max_count = 2000 }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'floggraph' },
        callback = function()
          vim.keymap.set('n', 'q', 'gq', { buffer = 0, remap = true })
        end,
      })
    end
  },
}

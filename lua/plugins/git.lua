return {
  {
    'airblade/vim-gitgutter',
    lazy = false,
    init = function()
      vim.g.gitgutter_preview_win_floating = 0
      vim.g.gitgutter_highlight_linenrs = 1
      vim.g.gitgutter_signs = 1
      vim.g.gitgutter_grep = 'rg'
      -- vim.api.nvim_set_hl(0, 'GitGutterAddLineNr', { link = 'GitGutterAdd' })
      -- vim.api.nvim_set_hl(0, 'GitGutterChangeLineNr', { link = 'GitGutterChange' })
      -- vim.api.nvim_set_hl(0, 'GitGutterDeleteLineNr', { link = 'GitGutterDelete' })
      -- vim.api.nvim_set_hl(0, 'GitGutterChangeDeleteLineNr', { link = 'GitGutterChangeDelete' })
      local nu = false
      vim.keymap.set('n', '<Leader>tn', function()
        nu = not nu
        -- Can't just toggle both, 'cause I could have independently toggled either
        if nu then
          vim.cmd('windo set nu')
          vim.cmd.GitGutterSignsDisable()
        else
          vim.cmd('windo set nonu')
          vim.cmd.GitGutterSignsEnable()
        end
      end, { desc = 'GitGutter: Preview Hunk' })
    end,
  },
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'git' },
        callback = function()
          vim.keymap.set('n', 'gq', '<CMD>q<CR>', { buffer = 0 })
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
    end
  },
}

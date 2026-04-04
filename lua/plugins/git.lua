return {
  { 'sindrets/diffview.nvim' },
  {
    'airblade/vim-gitgutter',
    lazy = false,
    init = function()
      vim.g.gitgutter_preview_win_floating = 0
      vim.g.gitgutter_highlight_linenrs = 1
      vim.g.gitgutter_signs = 0
      vim.cmd [[
        nmap [h <Plug>(GitGutterPrevHunk)
        nmap ]h <Plug>(GitGutterNextHunk)
        omap ih <Plug>(GitGutterTextObjectInnerPending)
        omap ah <Plug>(GitGutterTextObjectOuterPending)
        xmap ih <Plug>(GitGutterTextObjectInnerVisual)
        xmap ah <Plug>(GitGutterTextObjectOuterVisual)
      ]]
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
  },
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb', 'shumphrey/fugitive-gitlab.vim' },
    config = function()
      vim.g['fugitive_gitlab_domains'] = { 'https://gitlab.build-unite.unite.eu/' }
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

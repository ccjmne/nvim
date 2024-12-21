return {
  {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    config = function()
      local MiniDiff = require 'mini.diff'
      MiniDiff.setup {
        options = { algorithm = 'myers' },
        source = MiniDiff.gen_source.git(),
      }
      vim.keymap.set('n', '<Leader>td', MiniDiff.toggle_overlay, { desc = 'MiniDiff: Toggle Overlay' })
    end,
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'fugitiveblame' },
        callback = function()
          -- gq, unlike <CMD>q<CR>, jumps back to the current work-tree version
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
    end
  },
}

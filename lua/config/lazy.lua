-- https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {

    {
      'echasnovski/mini.files',
      lazy = false, -- To use as default directory browser
      keys = {
        { '-', '<CMD>lua MiniFiles.open()<CR>', 'Open mini.files' }
      },
      config = function()
        local MiniFiles = require('mini.files')

        function show_all() return true end
        function show_visible(fs_entry) return not vim.startswith(fs_entry.name, '.') end
        local filter = show_visible
        MiniFiles.setup { content = { filter = filter } }

        local toggle_dotfiles = function()
          filter = filter == show_visible and show_all or show_visible
          MiniFiles.refresh { content = { filter = filter } }
          MiniFiles.setup { content = { filter = filter } }
        end

        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
            vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = args.data.buf_id })
          end,
        })
      end,
    },

    { import = 'plugins' },
  }
})

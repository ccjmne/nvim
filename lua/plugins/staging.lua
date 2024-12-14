return {
  {
    'sphamba/smear-cursor.nvim',
    config = {},
  },
  {
    'echasnovski/mini.files',
    lazy = false, -- To use as default directory browser
    keys = {
      { '-', '<CMD>lua MiniFiles.open()<CR>', 'Open mini.files' }
    },
    config = function()
      local MiniFiles = require('mini.files')

      local function show_all() return true end
      local function show_visible(fs_entry) return not vim.startswith(fs_entry.name, '.') end
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
}

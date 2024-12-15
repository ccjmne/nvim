return {
  {
    -- 'aaronik/treewalker.nvim',
    'ccjmne/treewalker.nvim',
    opts = { highlight = 50 },
    keys = {
      { '<C-j>', ':Treewalker Down<CR>' },
      { '<C-k>', ':Treewalker Up<CR>' },
      { '<C-h>', ':Treewalker Left<CR>' },
      { '<C-l>', ':Treewalker Right<CR>' },
    }
  },
  {
    'sphamba/smear-cursor.nvim',
    config = {
      smear_between_neighbor_lines = false,
      legacy_computing_symbols_support = true,
    },
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

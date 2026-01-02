return {
  'tpope/vim-abolish',
  'stefandtw/quickfix-reflector.vim' ,
  {
    '73/vim-klog',
    config = function()
      vim.cmd('highlight link klogRecord Title')
    end,
  },
  {
    -- lazy.nvim will overrwrite runtimepath: this is the only way to do
    -- that while I'm sticking with lazy.nvim.
    -- TODO: consider dropping lazy.nvim, move this to init.lua.
    dir = '.',
    config = function()
      local localrt = vim.fn.finddir('.vimrt', ';')
      if localrt ~= '' then
        vim.opt.rtp:append(localrt)
        vim.cmd 'runtime! after/ftdetect/*.vim'
        vim.cmd 'runtime! after/ftplugin/*.vim'
        vim.notify('Added ' .. localrt .. ' to runtimepath', vim.log.levels.INFO)
      end
    end,
  },
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require 'oil'
      local columns = {
        { name = 'permissions', enabled = false },
        { name = 'size',        enabled = false },
        { name = 'mtime',       enabled = false },
      }

      local function toggle_column(idx)
        columns[idx].enabled = not columns[idx].enabled
        local cols = {}
        for _, column in ipairs(columns) do
          if column.enabled then
            table.insert(cols, column.name)
          end
        end
        oil.set_columns(cols)
      end

      oil.setup {
        skip_confirm_for_simple_edits = true,
        columns = {},
        keymaps = {
          ['gq'] = 'actions.close',
          ['gp'] = {
            desc = 'Toggle permissions',
            callback = function() toggle_column(1) end,
          },
          ['gs'] = {
            desc = 'Toggle size',
            callback = function() toggle_column(2) end,
          },
          ['gt'] = {
            desc = 'Toggle last modified time',
            callback = function() toggle_column(3) end,
          },
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}

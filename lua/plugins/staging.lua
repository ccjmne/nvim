return {
  {
    'aaronik/treewalker.nvim',
    opts = { highlight_duration = 50, highlight_group = 'CursorLine' },
    keys = {
      { '<C-j>', ':Treewalker Down<CR>' },
      { '<C-k>', ':Treewalker Up<CR>' },
      { '<C-h>', ':Treewalker Left<CR>' },
      { '<C-l>', ':Treewalker Right<CR>' },
    }
  },
  -- {
  --   'sphamba/smear-cursor.nvim',
  --   opts = {
  --     smear_between_neighbor_lines = false,
  --     legacy_computing_symbols_support = true,
  --   },
  -- },
  -- {
  --   'rcarriga/nvim-notify',
  --   config = function()
  --     local Notify = require 'notify'
  --     Notify.setup { render = 'minimal', merge_duplicates = true, stages = 'static' }
  --     vim.notify = Notify
  --   end,
  -- },
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
            callback = function() toggle_column(2) end,
          },
          ['gs'] = {
            desc = 'Toggle size',
            callback = function() toggle_column(3) end,
          },
          ['gt'] = {
            desc = 'Toggle last modified time',
            callback = function() toggle_column(4) end,
          },
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}

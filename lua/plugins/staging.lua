return {
  {
    'aaronik/treewalker.nvim',
    opts = { highlight_duration = 50 },
    keys = {
      { '<C-j>', ':Treewalker Down<CR>' },
      { '<C-k>', ':Treewalker Up<CR>' },
      { '<C-h>', ':Treewalker Left<CR>' },
      { '<C-l>', ':Treewalker Right<CR>' },
    }
  },
  {
    'github/copilot.vim',
    config = function()
      local enabled = true
      vim.keymap.set(
        'n', '<Leader>tc', function()
          enabled = not enabled
          vim.cmd('Copilot ' .. (enabled and 'enable' or 'disable'))
          vim.notify('Copilot ' .. (enabled and 'enabled' or 'disabled'))
        end,
        { desc = 'Toggle Copilot' })
    end
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },                       -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken',                          -- Only on MacOS or Linux
    config = function()
      require 'CopilotChat'.setup {}
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { 'copilot-chat' },
        callback = function() vim.wo.wrap = true end,
      })
    end
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
    'echasnovski/mini.files',
    lazy = false, -- To use as default directory browser
    keys = {
      {
        '-',
        function() MiniFiles.open(vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 and vim.api.nvim_buf_get_name(0) or nil) end,
        'Open mini.files',
      },
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

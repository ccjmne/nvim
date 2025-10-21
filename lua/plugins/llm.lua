return {
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
    keys = {
      {
        '<Leader>cp',
        function()
          require('CopilotChat.integrations.fzflua').pick(require('CopilotChat.actions').prompt_actions())
        end,
        mode = { 'n', 'v' },
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>co',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        mode = { 'n', 'v' },
        desc = 'CopilotChat - Quick chat',
      },
      { '<Leader>ct', '<CMD>CopilotChatToggle<CR>', mode = { 'n', 'v' }, { desc = 'Toggle Copilot Chat' } },
    },
    build = 'make tiktoken',
    config = function()
      require 'CopilotChat'.setup { model = 'gpt-5' }
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { 'copilot-chat' },
        callback = function() vim.wo.wrap = true end,
      })
    end,
  },
}

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
    build = 'make tiktoken',                          -- Only on MacOS or Linux
    config = function()
      require 'CopilotChat'.setup {}
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { 'copilot-chat' },
        callback = function() vim.wo.wrap = true end,
      })
    end
  },
}

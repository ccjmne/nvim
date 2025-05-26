return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fm',
      function() require 'conform'.format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>tf',
      function()
        vim.g.format_on_save = not vim.g.format_on_save
        print('Format-on-save ' .. (vim.g.format_on_save and 'enabled' or 'disabled'))
      end,
      mode = '',
      desc = '[T]oggle [F]ormat on save',
    },
  },
  config = function()
    require 'conform'.setup({
      formatters_by_ft = {
        lua = { 'stylua', lsp_format = 'fallback' },
        javascript = { 'eslint_d', 'eslint', 'prettier', stop_after_first = true },
        typescript = { 'eslint_d', 'eslint', 'prettier', stop_after_first = true },
        json = { 'eslint_d' },
      },
      format_on_save = function()
        if vim.g.format_on_save then
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

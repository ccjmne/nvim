return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    keys = function(_, keys)
      local inline = true
      return {
        {
          '<Leader>tq',
          function()
            inline = not inline
            vim.diagnostic.config { virtual_text = inline, virtual_lines = not inline }
          end,
          desc = '[T]oggle Diagnostics Style',
        },
        unpack(keys),
      }
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        -- svelte = { 'eslint_d' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then lint.try_lint() end
        end,
      })
    end,
  },
}

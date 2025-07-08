vim.diagnostic.config({
  float = { source = true },
  severity_sort = true,
  signs = true, -- gutter signs
  underline = false,
  update_in_insert = false,
})

local inline = true
vim.keymap.set('n', '<Leader>tq', function()
  inline = not inline
  vim.diagnostic.config({ virtual_text = inline, virtual_lines = not inline })
end)

return {
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
        json = { 'eslint_d' },
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

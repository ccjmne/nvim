return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  config = function()
    require('lspconfig').lua_ls.setup {}
    -- These will ship by default with 0.11, presumably
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'grr', vim.lsp.buf.references)
  end
}

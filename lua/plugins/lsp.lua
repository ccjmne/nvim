return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
    keys = function(_, keys)
      local inline = true
      return {
        {
          '<leader>tq',
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
    end
  }
}

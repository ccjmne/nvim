return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      'nvim-java/nvim-java',
    },
    config = function()
      require 'mason'.setup {}
      require 'mason-lspconfig'.setup()
      local capabilities = require 'blink.cmp'.get_lsp_capabilities()
      require 'lspconfig'.lua_ls.setup { capabilities = capabilities }
      require 'lspconfig'.ts_ls.setup { capabilities = capabilities }
      require 'lspconfig'.rust_analyzer.setup { capabilities = capabilities }
      require 'lspconfig'.tailwindcss.setup { capabilities = capabilities }
      require 'lspconfig'.svelte.setup { capabilities = capabilities }
      require 'lspconfig'.glslls.setup {
        capabilities = capabilities,
        cmd = { 'glslls', '--stdin', '--target-env', 'opengl' },
      }
      require 'java'.setup()
      require 'lspconfig'.jdtls.setup { capabilities = capabilities }
    end
  },
}

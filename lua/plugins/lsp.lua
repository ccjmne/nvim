return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      { 'pmizio/typescript-tools.nvim', dependencies = 'nvim-lua/plenary.nvim' },
      'saghen/blink.cmp',
    },
    config = function()
      require 'mason'.setup {}
      local capabilities = require 'blink.cmp'.get_lsp_capabilities()
      require 'typescript-tools'.setup { capabilities = capabilities }

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim', 'require' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      vim.lsp.enable { -- TODO: use blink's capabilities
        'bashls',
        'clangd',
        'css_variables',
        'glslls', -- TODO: cmd = { 'glslls', '--stdin', '--target-env', 'opengl' }
        'lua_ls',
        'rust_analyzer',
        'somesass_ls',
        'svelte',
        'tailwindcss',
      }
    end
  },
}

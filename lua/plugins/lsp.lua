return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
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

      require 'lspconfig'.lua_ls.setup {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }
    end
  },
}

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
      require 'mason-lspconfig'.setup({
        automatic_enable = { -- https://github.com/mason-org/mason-lspconfig.nvim?tab=readme-ov-file#default-configuration
          exclude = { 'lua_ls', 'ts_ls', 'rust_analyzer', 'tailwindcss', 'svelte', 'glslls' },
        },
      })
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
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
            }
          })
        end,
        settings = { Lua = {} }
      }
    end
  },
}

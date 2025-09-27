return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      { 'pmizio/typescript-tools.nvim', dependencies = 'nvim-lua/plenary.nvim' },
      'saghen/blink.cmp',
      -- 'nvim-java/nvim-java',
    },
    config = function()
      require 'mason'.setup {}
      -- require 'mason-lspconfig'.setup({
      --   automatic_enable = { -- https://github.com/mason-org/mason-lspconfig.nvim?tab=readme-ov-file#default-configuration
      --     exclude = { 'lua_ls', 'ts_ls', 'rust_analyzer', 'tailwindcss', 'svelte', 'glslls' },
      --   },
      -- })
      local capabilities = require 'blink.cmp'.get_lsp_capabilities()
      require 'lspconfig'.rust_analyzer.setup { capabilities = capabilities }
      require 'lspconfig'.tailwindcss.setup { capabilities = capabilities }
      require 'lspconfig'.svelte.setup { capabilities = capabilities }
      require 'lspconfig'.somesass_ls.setup { capabilities = capabilities }
      require 'lspconfig'.css_variables.setup { capabilities = capabilities }
      require 'lspconfig'.bashls.setup { capabilities = capabilities }
      require 'lspconfig'.glslls.setup {
        capabilities = capabilities,
        cmd = { 'glslls', '--stdin', '--target-env', 'opengl' },
      }
      -- require 'java'.setup()
      -- require 'lspconfig'.jdtls.setup { capabilities = capabilities }

      require 'typescript-tools'.setup { capabilities = capabilities }

      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
              }
            }
          })
        end,
        settings = { Lua = {} }
      })
      vim.lsp.enable('lua_ls')
    end
  },
}

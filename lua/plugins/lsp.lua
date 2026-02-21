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

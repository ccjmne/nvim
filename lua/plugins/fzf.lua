return {
  -- TODO: Check out "profiles" and set up my own
  'ibhagwan/fzf-lua',
  dependencies = {
    -- TODO: Figure out whether/how to integrate icons
    'echasnovski/mini.icons',
  },
  keys = {
    { '<Leader>ff', function() require 'fzf-lua'.files {} end,                                        desc = 'Find in CWD' },
    { '<Leader>fn', function() require 'fzf-lua'.files { cwd = vim.fn.stdpath 'config' } end,         desc = 'Find in Neovim config' },
    { '<Leader>f,', function() require 'fzf-lua'.files { cwd = vim.env.HOME .. '/git/dotfiles2025' } end, desc = 'Find in new dotfiles' },
    { '<Leader> ',  function() require 'fzf-lua'.buffers {} end,                                      desc = 'Find buffers' },
    { '<Leader>-',  function() require 'fzf-lua'.oldfiles {} end,                                     desc = 'Find recent files' },

    { '<Leader>fg', function() require 'fzf-lua'.live_grep_glob {} end,                               desc = 'Grep with glob support' },
    { '<Leader>fv', function() require 'fzf-lua'.grep_visual {} end,                                  desc = 'Grep visual selection',       mode = { 'n', 'v' } },
    { '<Leader>fw', function() require 'fzf-lua'.grep_cword {} end,                                   desc = 'Grep for word under cursor' },
    { '<Leader>fW', function() require 'fzf-lua'.grep_cWORD {} end,                                   desc = 'Grep for WORD under cursor' },

    { '<Leader>fr', function() require 'fzf-lua'.resume {} end,                                       desc = 'Resume search' },
    { '<Leader>f?', function() require 'fzf-lua'.builtin {} end,                                      desc = 'Find builtin fzf-lua command' },
    { '<Leader>fh', function() require 'fzf-lua'.helptags {} end,                                     desc = 'Find help tags' },
    { '<Leader>fk', function() require 'fzf-lua'.keymaps {} end,                                      desc = 'Find keymaps' },

    -- Doesn't work nearly as well as it should... probably has to do with the fact that each language has its own nodes types.
    -- Still though, why not support Lua out of the box? I must be missing something.
    { '<Leader>ft', function() require 'fzf-lua'.treesitter {} end,                                   desc = 'Find Treesitter symbols' },

    { '<Leader>ds', function() require 'fzf-lua'.lsp_document_symbols {} end,                         desc = 'Find document symbols' },
    { '<Leader>ws', function() require 'fzf-lua'.lsp_workspace_symbols {} end,                        desc = 'Find workspace symbols' },

    -- TODO: Finish figuring out how to set up quickfix and loclist from diagnostics without any hitches
    -- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua and the supporting keymaps.lua
    -- Also consider https://github.com/kevinhwang91/nvim-bqf
    { '<Leader>fq', function() require 'fzf-lua'.quickfix {} end,                                     desc = 'Find in qflist' },
    { '<Leader>fl', function() require 'fzf-lua'.loclist {} end,                                      desc = 'Find in loclist' },

    {
      '<Leader>fa',
      function()
        local gitdir = vim.fn.fnamemodify(vim.fn.finddir('.git', '.;'), ':p:h')
        require 'fzf-lua'.fzf_exec("git --git-dir=" .. gitdir .. " log --pretty='%aN <%aE>' --all | awk '!M[$0]++'", {
          prompt = 'Contributors> ',
          fzf_opts = { ['--multi'] = true },
          preview = { field_index = '{+}', fn = function(s) return table.concat(s, '\n') end },
          actions = { ['default'] = function(s) vim.api.nvim_put(s, 'v', true, true) end },
        })
      end,
      desc = 'Find contributors'
    },
  },
  config = function()
    require 'fzf-lua'.setup {
      'borderless',
       -- TODO: Would be nice to have some difference in colouring
       -- between the search and preview panels
      fzf_colors = false,
      previewers = {
        builtin = { syntax_limit_b = 1024 * 100 },
      },
    }
    -- TODO: If I'm going to do that, I'll have to also boot up fzf-lua on anything and everything that would trigger a ui-select.
    require 'fzf-lua'.register_ui_select()
  end
}

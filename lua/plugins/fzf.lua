return {
  -- TODO: Check out "profiles" and set up my own
  'ibhagwan/fzf-lua',
  lazy = false,
  keys = {
    { '<Leader>ff', function() require 'fzf-lua'.files {} end },
    { '<Leader>fn', function() require 'fzf-lua'.files { cwd = vim.fn.stdpath 'config' } end },
    { '<Leader>f,', function() require 'fzf-lua'.files { cwd = vim.env.HOME .. '/git/dotfiles2025' } end },
    { '<Leader> ',  function() require 'fzf-lua'.buffers {} end },
    { '<Leader>-',  function() require 'fzf-lua'.oldfiles {} end },
    { '<Leader>f"', function() require 'fzf-lua'.registers {} end },

    { '<Leader>fg', function() require 'fzf-lua'.live_grep {} end },
    { '<Leader>fv', function() require 'fzf-lua'.grep_visual {} end, mode = { 'n', 'v' } },
    { '<Leader>fw', function() require 'fzf-lua'.grep_cword {} end },
    { '<Leader>fW', function() require 'fzf-lua'.grep_cWORD {} end },

    { '<Leader>fr', function() require 'fzf-lua'.resume {} end },
    { '<Leader>f?', function() require 'fzf-lua'.builtin {} end },
    { '<Leader>fh', function() require 'fzf-lua'.helptags {} end },
    { '<Leader>fk', function() require 'fzf-lua'.keymaps {} end },

    { '<Leader>ft', function() require 'fzf-lua'.treesitter {} end },
    { '<Leader>ds', function() require 'fzf-lua'.lsp_document_symbols {} end },
    { '<Leader>ws', function() require 'fzf-lua'.lsp_workspace_symbols {} end },

    -- TODO: Finish figuring out how to set up quickfix and loclist from diagnostics without any hitches
    -- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua and the supporting keymaps.lua
    -- Also consider https://github.com/kevinhwang91/nvim-bqf
    { '<Leader>fq', function() require 'fzf-lua'.quickfix {} end },
    { '<Leader>fl', function() require 'fzf-lua'.loclist {} end },
    { 'z=',         function() require 'fzf-lua'.spell_suggest {} end },
    {
      '<Leader>fd',
      function()
        require 'fzf-lua'.fzf_exec("fd --type directory", {
          prompt = vim.fn.fnamemodify(vim.fn.getcwd(), ':~') .. '> ',
          actions = { ['default'] = function(s) vim.cmd('Oil ' .. s[1]) end },
        })
      end,
    },
    {
      '<Leader>fc',
      function()
        -- TODO: Deduplicate entries, through case at least, through email if realistically feasible
        -- TODO: Use git interpret-trailers to modify the buffer
        -- TODO: Also switch between Co-authored-by, Signed-off-by, Reviewed-by, Acked-by, etc.
        -- TODO: Also find people from these trailers
        local trailers = { 'Signed-off-by', 'Reviewed-by', 'Acked-by', 'Tested-by', 'Reported-by', 'Suggested-by', 'Co-developed-by', 'Co-authored-by' }
        local fmt = '%an <%aE>%n%cn <%cE>%n' .. table.concat(vim.tbl_map(function(t) return '%(trailers:key=' .. t .. ',valueonly)' end, trailers), '%n')
        local gitdir = vim.fn.fnamemodify(vim.fn.finddir('.git', '.;'), ':p:h')
        require 'fzf-lua'.fzf_exec("git --git-dir=" .. gitdir .. " log --pretty='" .. fmt .. "' --all | awk '$0 && !M[$0]++'", {
          prompt = 'Contributors> ',
          fzf_opts = { ['--multi'] = true },
          preview = { field_index = '{+}', fn = function(s) return table.concat(s, '\n') end },
          actions = { ['default'] = function(s) vim.api.nvim_put(s, 'v', true, true) end },
        })
      end,
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
      grep = { rg_opts = '--hidden --line-number --column --smart-case' },
      files = { fd_opts = '--hidden' },
    }
    -- TODO: If I'm going to do that, I'll have to also boot up fzf-lua on anything and everything that would trigger a ui-select.
    require 'fzf-lua'.register_ui_select()
  end
}

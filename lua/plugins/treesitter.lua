return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'markdown', 'javascript', 'typescript', 'java', 'query' },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'gS', '<Cmd>TSJSplit<CR>', desc = 'Split TSNode' },
      { 'gJ', '<Cmd>TSJJoin<CR>', desc = 'Join TSNode' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'master', -- important for now, since the default soon will be `main`, whose API is incompatible and I'm not ready for the switch yet
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'lua', 'vim', 'markdown', 'javascript', 'typescript', 'java', 'query', 'diff', 'git_rebase' },
        auto_install = false,
        highlight = {
          enable = true,
          language_tree = true,
          disable = function(lang, buf)
            -- This lang parameter is the tree-sitter language, not quite the filetype.
            -- When aren't they matching?
            local ft = vim.bo[buf or 0].filetype
            if lang ~= ft then
              vim.notify(
                string.format('Treesitter language "%s" does not match filetype "%s"', lang, ft),
                vim.log.levels.WARN
              )
            end
            return ({ gitcommit = true })[ft]
                or vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 100
          end,
        },
      }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'query' },
        callback = function()
          vim.keymap.set('n', 'gq', '<CMD>q<CR>', { buffer = 0 })
        end,
      })
    end,
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'gS', '<CMD>TSJSplit<CR>', desc = 'Split TSNode' },
      { 'gJ', '<CMD>TSJJoin<CR>',  desc = 'Join TSNode' },
    },
    opts = { use_default_keymaps = false, max_join_length = 500 },
  },
}

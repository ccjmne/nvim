local localrt = vim.fn.finddir('.vimrt', ';')
return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '1.*',
  opts = {
    sources = { providers = { snippets = { opts = {
      search_paths = localrt ~= '' and { localrt .. '/snippets' } or {}
    }}}},
  },
  opts_extend = { 'sources.default' }
}

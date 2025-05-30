vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

vim.opt.fillchars:append({ fold = ' ' })
vim.opt.foldtext = ''
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})

vim.keymap.set('n', [[]], [[mz:tabe %`zzz]])

vim.keymap.set('n', 'y<C-G>', function()
  vim.fn.setreg(
    vim.v.register,
    vim.fn.exists('*fugitive#Object') == 1 and vim.fn['fugitive#Object'](vim.fn.expand('%')) or vim.fn.expand('%')
  )
end)

vim.keymap.set('n', '<Leader>x', [[:.lua<CR>]])
vim.keymap.set('v', '<Leader>x', [[:lua<CR>]])
vim.keymap.set('n', '<Leader>z', [[:<C-R><C-L><CR>]])
vim.keymap.set('v', '<leader>z', [[:<C-u>let @v = join(getline("'<", "'>"), "\n")<CR>:@v<CR>]])

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR><CMD>cclose<CR><CMD>pclose<CR>', { desc = 'Clear search highlight, close preview/quickfix' })

vim.diagnostic.config { virtual_text = true }
-- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua
-- Also consider https://github.com/kevinhwang91/nvim-bqf
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, { desc = 'Put diagnostics to qflist' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist, { desc = 'Put diagnostics to loclist' })


-- Keep cursor centred when scrolling
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv')

local bufs = vim.fn.argv()
if #bufs > 1 then ---@cast bufs string[]
  local qflist = {}
  for _, name in ipairs(bufs) do
    table.insert(qflist, { filename = name })
  end
  vim.fn.setqflist(qflist)
  vim.cmd('copen')
end

vim.api.nvim_create_user_command('Title', function(opts)
  local padchar = opts.fargs[1] or '-'
  local center = opts.bang -- Use `Title!` to center the title
  local lo, hi
  if opts.count == -1 then -- Normal mode, see https://www.petergundel.de/neovim/lua/hack/2023/12/17/get-neovim-mode-when-executing-a-command.html
    lo, hi = vim.fn.line '.', vim.fn.line '.'
  else
    _, lo = unpack(vim.fn.getpos "'<")
    _, hi = unpack(vim.fn.getpos "'>")
  end

  for i = lo, hi do
    local indent = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:match('^%s*')
    local head = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:gsub('^[%.=-]*%s*', ''):gsub('%s*[%.=-]*$', '')
    local pad = (vim.bo.textwidth > 0 and vim.bo.textwidth or 80) - #indent - #head - 2
    if center then
      if pad > 0 then
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, { indent .. string.rep(padchar, math.floor(pad / 2)) .. ' ' .. head .. ' ' .. string.rep(padchar, math.ceil(pad / 2)) })
      end
    else
      if pad >= 0 then
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, { indent .. head .. ' ' .. string.rep(padchar, pad + 1) })
      end
    end
  end
end, { range = true, nargs = '?', bang = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'qf' },
  callback = function()
    -- TODO: Consider mapping to :bd or :BD, along with other :q mappings
    vim.keymap.set('n', 'gq', '<CMD>q<CR>', { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set({ 'n', 't' }, '<Leader>tt', function()
  vim.cmd('new')
  vim.cmd('wincmd J')
  vim.cmd('term')
  vim.cmd('startinsert')
  vim.api.nvim_win_set_height(0, 15)
end)

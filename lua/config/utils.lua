vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

vim.keymap.set('n', '<Leader>x', '<CMD>.lua<CR>')
vim.keymap.set('n', '<Leader><Leader>x', '<CMD>source %<CR>')
vim.keymap.set('v', '<Leader>x', ':lua<CR>')

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR><CMD>cclose<CR><CMD>pclose<CR>', { desc = 'Clear search highlight, close preview/quickfix' })

vim.diagnostic.config { virtual_text = true }
-- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua
-- Also consider https://github.com/kevinhwang91/nvim-bqf
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, { desc = 'Put diagnostics to qflist' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist, { desc = 'Put diagnostics to loclist' })

vim.keymap.set('n', '<C-n>', '<CMD>cnext<CR>', { desc = 'Jump to next quickfix entry' })
vim.keymap.set('n', '<C-p>', '<CMD>cprev<CR>', { desc = 'Jump to previous quickfix entry' })

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
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })
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

-- TODO: move to set.lua
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.fillchars:append({ fold = ' ' })
vim.opt.foldtext = ''
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- TODO: prefer actually only setting fdm to expr if and only iff treesitter folds are available for the buffer
vim.cmd "autocmd BufWinEnter * if &buftype == '' | set fdm=manual | endif"

-- TODO: consider a more comprehensive session management solution; I think tpope has something to that effect
vim.cmd[[
  set viewoptions-=curdir
  augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
  augroup END
]]

-- TODO: move to au.lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    if vim.lsp.get_client_by_id(args.data.client_id):supports_method('textDocument/foldingRange') then
      vim.wo[vim.api.nvim_get_current_win()][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

-- TODO: move to map.lua
vim.keymap.set('n', '<Leader>ve', function()
  vim.b.virtualedit = not vim.b.virtualedit
  if vim.b.virtualedit then vim.cmd('setlocal ve=all cuc')
                       else vim.cmd('setlocal ve& cuc&')
  end
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})

vim.keymap.set('n', '<C-W><C-E>', 'mz:tabe %<C-M>`zzzzv')

vim.cmd [[
  nmap y<C-G> <CMD>call setreg(v:register, exists('*fugitive#Object') ? fugitive#Object(expand('%')) : expand('%'))<CR>
]]

vim.keymap.set('n', '<Leader>x', [[:.lua<CR>]])
vim.keymap.set('v', '<Leader>x', [[:lua<CR>]])
vim.keymap.set('n', '<Leader>z', [[:<C-R><C-L><CR>]])
vim.keymap.set('v', '<Leader>z', [[:let @v = join(getline("'<", "'>"), "\n")<CR>:@v<CR>]])

vim.keymap.set('n', '<Esc>', '<CMD>nohl<CR><CMD>lcl<CR><CMD>ccl<CR><CMD>pc<CR>')

vim.diagnostic.config { virtual_text = true }
-- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua
-- Also consider https://github.com/kevinhwang91/nvim-bqf
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, { desc = 'Put diagnostics to qflist' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist, { desc = 'Put diagnostics to loclist' })

vim.cmd [[ " recall cmd starting with the current line
  cmap <M-j> <Down>
  cmap <M-k> <Up>
]]

vim.keymap.set('n', '<M-j>', '<CMD>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<CMD>cprev<CR>')
vim.keymap.set('n', '<M-h>', '<CMD>cold<CR>')
vim.keymap.set('n', '<M-l>', '<CMD>cnew<CR>')

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

-- TODO: Just like :left, :right, :center, let it take a "width" argument
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

vim.keymap.set({ 'n' }, '<Leader>tt', function()
  vim.cmd [[
    vertical term
    wincmd J
    resize 15
    startinsert
  ]]
end)

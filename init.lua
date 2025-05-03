vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true
vim.opt.guicursor = ''
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.updatetime = 160
vim.opt.timeoutlen = 320
vim.opt.grepprg = vim.fn.executable('rg') == 1 and 'rg --vimgrep' or vim.opt.grepprg

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.hlsearch = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', precedes = '<', extends = '>' }

vim.opt.laststatus = 0

require('config.utils')
require('config.lazy')

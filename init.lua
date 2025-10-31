vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.spelllang = 'en_gb'

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.foldcolumn = '0'

vim.o.cursorline = true
vim.o.guicursor = ''
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = false

vim.o.undofile = true
vim.o.updatetime = 160
vim.o.timeoutlen = 320
vim.o.grepprg = vim.fn.executable('rg') == 1 and 'rg --vimgrep' or vim.o.grepprg

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.inccommand = 'split'
vim.o.hlsearch = true

vim.o.laststatus = 1
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.fillchars='vert:█,horiz:█,horizup:█,horizdown:█,vertleft:█,vertright:█,verthoriz:█'

vim.o.list = true
vim.o.listchars='tab:» ,trail:·,nbsp:␣,precedes:<,extends:>'

require('config.utils')
require('config.lazy')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', precedes = '<', extends = '>' }

require('config.utils')
require('config.lazy')

vim.keymap.set('n', '<Leader>x', '<CMD>.lua<CR>')
vim.keymap.set('n', '<Leader><Leader>x', '<CMD>source %<CR>')

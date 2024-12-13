vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

require('config.utils')
require('config.lazy')

vim.keymap.set('n', '<Leader>x', '<CMD>.lua<CR>')
vim.keymap.set('n', '<Leader><Leader>x', '<CMD>source %<CR>')

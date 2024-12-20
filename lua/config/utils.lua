vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

vim.keymap.set('n', '<Leader>x', '<CMD>.lua<CR>')
vim.keymap.set('n', '<Leader><Leader>x', '<CMD>source %<CR>')
vim.keymap.set('v', '<Leader>x', ':lua<CR>')

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>')
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

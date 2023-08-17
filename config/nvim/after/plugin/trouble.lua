local trouble = require('trouble')

vim.keymap.set('n', '<leader>t', trouble.open, { desc = "Show diagnostics" })
vim.keymap.set('n', '<leader>xx', trouble.open, { desc = "Show diagnostics" })
vim.keymap.set('n', '<leader>xd', function() trouble.open('document_diagnostics') end,
  { desc = "Show document diagnostics" })

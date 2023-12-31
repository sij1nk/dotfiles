local opts = { noremap = true, silent = true }

local make_opts = function(description)
  return vim.tbl_extend("keep", opts, { desc = description })
end

vim.keymap.set('n', '<leader>ngg', ":lua require('neogen').generate()<CR>", make_opts("Generate annotation"))

-- Supported annotation types: func, class, type, file
vim.keymap.set('n', '<leader>ngf', ":lua require('neogen').generate({ type = 'func'})<CR>", make_opts("Generate function annotation"))
vim.keymap.set('n', '<leader>ngc', ":lua require('neogen').generate({ type = 'class'})<CR>", make_opts("Generate class annotation"))
vim.keymap.set('n', '<leader>ngt', ":lua require('neogen').generate({ type = 'type'})<CR>", make_opts("Generate type annotation"))
vim.keymap.set('n', '<leader>ngF', ":lua require('neogen').generate({ type = 'file'})<CR>", make_opts("Generate file annotation"))

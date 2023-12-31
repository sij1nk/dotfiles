local wk = require('which-key')

wk.register({
  ["<leader>x"] = {
    name = "Documentation"
  }
})

local opts = { noremap = true, silent = true }

local make_opts = function(description)
  return vim.tbl_extend("keep", opts, { desc = description })
end

vim.keymap.set('n', '<leader>xx', ":lua require('neogen').generate()<CR>", make_opts("Generate annotation"))

-- Supported annotation types: func, class, type, file
vim.keymap.set('n', '<leader>xf', ":lua require('neogen').generate({ type = 'func'})<CR>", make_opts("Generate function annotation"))
vim.keymap.set('n', '<leader>xc', ":lua require('neogen').generate({ type = 'class'})<CR>", make_opts("Generate class annotation"))
vim.keymap.set('n', '<leader>xt', ":lua require('neogen').generate({ type = 'type'})<CR>", make_opts("Generate type annotation"))
vim.keymap.set('n', '<leader>xF', ":lua require('neogen').generate({ type = 'file'})<CR>", make_opts("Generate file annotation"))

vim.api.nvim_set_var('sonokai_style', [[espresso]])
vim.api.nvim_set_var('sonokai_enable_italic', 1)
vim.api.nvim_set_var('sonokai_disable_italic_comment', 0)

vim.cmd [[colorscheme melange]]

vim.api.nvim_command [[highlight Normal guibg = NONE]]
vim.api.nvim_command [[highlight NonText guibg = NONE]]
vim.api.nvim_command [[highlight EndOfBuffer guibg = NONE]]

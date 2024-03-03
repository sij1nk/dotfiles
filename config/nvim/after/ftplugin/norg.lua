vim.o.textwidth = 80
vim.o.conceallevel = 2

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NeorgAutoOpenFolds", {}),
  pattern = { "*.norg" },
  command = "normal zn<CR>",
})

local formatter = require("formatter")
local util = require("formatter.util")

formatter.setup({
  filetype = {
    html = {
      require("formatter.filetypes.html").prettierd,
    },
    css = {
      require("formatter.filetypes.css").prettierd,
    },
    javascript = {
      require("formatter.filetypes.javascript").prettierd,
    },
    javascriptreact = {
      require("formatter.filetypes.javascript").prettierd,
    },
    typescript = {
      require("formatter.filetypes.javascript").prettierd,
    },
    typescriptreact = {
      require("formatter.filetypes.javascript").prettierd,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    cpp = {
      require("formatter.filetypes.cpp").clangformat,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("FormatPrettier", {}),
  pattern = { "*.html", "*.css", "*.scss", "*.js", "*.jsx", "*.ts", "*.tsx" },
  command = "FormatWrite",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("FormatCpp", {}),
  pattern = { "*.cpp", "*.cxx", "*.h", "*.hpp", "*.hxx" },
  command = "FormatWrite",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("FormatRust", {}),
  pattern = { "*.rs" },
  command = "FormatWrite",
})

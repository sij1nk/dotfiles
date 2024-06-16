-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local theme_persistence = require("config.theme_persistence")

vim.api.nvim_create_autocmd("Signal", {
  group = vim.api.nvim_create_augroup("UpdateTheme", {}),
  pattern = "SIGUSR1",
  callback = theme_persistence.update_theme_from_file,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("UpdateTheme", {}),
  pattern = "nvim-theme",
  callback = function()
    theme_persistence.update_theme_from_file()
    theme_persistence.notify_nvim_instances()
  end,
})

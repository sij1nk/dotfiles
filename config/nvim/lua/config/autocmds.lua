-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local theme_persistence = require("config.theme_persistence")

local update_theme_augroup = vim.api.nvim_create_augroup("UpdateTheme", {})

vim.api.nvim_create_autocmd("Signal", {
  group = update_theme_augroup,
  pattern = "SIGUSR1",
  callback = theme_persistence.update_theme_from_file,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = update_theme_augroup,
  pattern = "nvim-theme",
  callback = function()
    theme_persistence.update_theme_from_file()
    theme_persistence.notify_nvim_instances()
  end,
})

local create_bookmark_augroup = vim.api.nvim_create_augroup("CreateBookmark", {})

vim.api.nvim_create_autocmd("BufUnload", {
  group = create_bookmark_augroup,
  pattern = "/tmp/new_bookmark",
  callback = function()
    vim.system({ "create-bookmark" })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = create_bookmark_augroup,
  pattern = "/tmp/new_bookmark",
  callback = function()
    vim.bo.filetype = "conf"
  end,
})

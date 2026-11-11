-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "snacks"

vim.g.maplocalleader = ","
vim.o.list = false
vim.o.swapfile = false

vim.o.list = true
vim.o.listchars = "trail:~,nbsp:␣"

vim.g.cmp_widths = {
  abbr = 60,
}

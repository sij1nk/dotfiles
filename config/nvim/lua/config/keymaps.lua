-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gh", "^", { desc = "Move to line content beginning" })
vim.keymap.set("n", "gH", "0", { desc = "Move to line beginning" })
vim.keymap.set("n", "gl", "$", { desc = "Move to line end" })

-- custom replace keymaps instead of the weird nvim-spectre stuff

local wk = require("which-key")
wk.add({
  { "<leader>r", group = "Replace" },
})

vim.keymap.set("n", "<leader>rg", [[:%s//g<Left><Left>]], { desc = "Replace" })
vim.keymap.set("n", "<leader>rG", [[:%s//gc<Left><Left>]], { desc = "Replace with confirm" })
vim.keymap.set("x", "<leader>rg", [[:s//g<Left><Left>]], { desc = "Replace" })
vim.keymap.set("x", "<leader>rG", [[:s//gc<Left><Left>]], { desc = "Replace with confirm" })
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]], { desc = "Replace word" })
vim.keymap.set(
  "n",
  "<leader>rW",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gC<Left><Left>]],
  { desc = "Replace word with confirm" }
)

-- hack to get group desciption for tresitter textobject swap binds to work
wk.add({
  { "gS", group = "Swap" },
  { "gSx", hidden = true },
})
vim.keymap.set("n", "gSx", "")

-- more similar window split commands to zellij pane bindings

vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")

vim.keymap.set("n", "<leader>wn", "<C-W>s", { desc = "Split Window Below" })
vim.keymap.set("n", "<leader>wd", "<C-W>s", { desc = "Split Window Below" })
vim.keymap.set("n", "<leader>wr", "<C-W>v", { desc = "Split Window Right" })
vim.keymap.set("n", "<leader>wx", "<C-W>q", { desc = "Quit Window" })

-- the "move lines" keybinds use Alt, which would conflict with zellij...
-- I didn't bother with removing the which-key hints for these, since I don't actually know
-- how to make them appear in the first place

vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

-- cursor and history movement in command mode

vim.keymap.set("c", "<C-h>", "<Left>", { silent = false })
vim.keymap.set("c", "<C-j>", "<Down>", { silent = false })
vim.keymap.set("c", "<C-k>", "<Up>", { silent = false })
vim.keymap.set("c", "<C-l>", "<Right>", { silent = false })

vim.keymap.set("n", "<cr>", "<cmd>w<cr>")

-- theme

local theme_persistence = require("config.theme_persistence")

vim.keymap.del("n", "<leader>ub")

vim.keymap.set("n", "<leader>ub", theme_persistence.toggle, { desc = "Toggle Background" })
vim.keymap.set("n", "<leader>uB", theme_persistence.update_theme_from_file, { desc = "Update Background From Cache" })

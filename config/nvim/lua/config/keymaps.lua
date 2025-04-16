-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gm", "^", { desc = "Move to line content beginning" })
vim.keymap.set("n", "gM", "0", { desc = "Move to line beginning" })
vim.keymap.set("n", "gi", "$", { desc = "Move to line end" })

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

vim.keymap.set({ "n", "v" }, "m", "h", { desc = "Left" })
vim.keymap.set({ "n", "v" }, "n", "j", { desc = "Down" })
vim.keymap.set({ "n", "v" }, "e", "k", { desc = "Up" })
vim.keymap.set({ "n", "v" }, "i", "l", { desc = "Right" })

vim.keymap.set("n", "j", "n", { desc = "Next Search Result" })
vim.keymap.set("n", "J", "N", { desc = "Prev Search Result" })

vim.keymap.set("n", "l", "e", { desc = "Next end of word" })
vim.keymap.set("n", "L", "E", { desc = "Next end of WORD" })

vim.keymap.set("n", "h", "i", { desc = "Insert" })
vim.keymap.set("n", "H", "I", { desc = "Insert at line beginning" })

vim.keymap.set("n", "M", "<C-o>", { desc = "Prev in jumplist" })
vim.keymap.set("n", "I", "<C-i>", { desc = "Next in jumplist" })

vim.keymap.set("n", "N", "<C-d>", { desc = "Scroll down" })
vim.keymap.set("n", "E", "<C-u>", { desc = "Scroll up" })

vim.keymap.set("n", "gn", "J", { desc = "Join lines" })

vim.keymap.set("n", "gj", "gn", { desc = "Search forwards and select" })
vim.keymap.set("n", "gJ", "gN", { desc = "Search backwards and select" })

vim.keymap.del("n", "gN")
wk.add({ { "gN", hidden = true } })

vim.keymap.set("n", "<leader>M", "m", { desc = "Mark" })

-- more similar window split commands to zellij pane bindings

vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
-- I don't need these
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>wm")

-- I have no need for hjkl binds, but since they're built-in bindings, they can't be disabled by doing `vim.keymap.del`
vim.keymap.set("n", "<C-w>h", "<nop>")
vim.keymap.set("n", "<C-w>j", "<nop>")
vim.keymap.set("n", "<C-w>k", "<nop>")
vim.keymap.set("n", "<C-w>l", "<nop>")
vim.keymap.set("n", "<C-w>H", "<nop>")
vim.keymap.set("n", "<C-w>J", "<nop>")
vim.keymap.set("n", "<C-w>K", "<nop>")
vim.keymap.set("n", "<C-w>L", "<nop>")

wk.add({
  { "<C-w>h", hidden = true },
  { "<C-w>j", hidden = true },
  { "<C-w>k", hidden = true },
  { "<C-w>l", hidden = true },
  { "<C-w>H", hidden = true },
  { "<C-w>J", hidden = true },
  { "<C-w>K", hidden = true },
  { "<C-w>L", hidden = true },
})

vim.keymap.set("n", "<leader>tm", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<leader>tn", "<C-w>j", { desc = "Go to the down window" })
vim.keymap.set("n", "<leader>te", "<C-w>k", { desc = "Go to the up window" })
vim.keymap.set("n", "<leader>ti", "<C-w>l", { desc = "Go to the right window" })
vim.keymap.set("n", "<leader>tM", "<C-w>H", { desc = "Move window to far left" })
vim.keymap.set("n", "<leader>tN", "<C-w>J", { desc = "Move window to far bottom" })
vim.keymap.set("n", "<leader>tE", "<C-w>K", { desc = "Move window to far top" })
vim.keymap.set("n", "<leader>tI", "<C-w>L", { desc = "Move window to far right" })
vim.keymap.set("n", "<leader>td", "<C-w>s", { desc = "Split Window Below" })
vim.keymap.set("n", "<leader>tr", "<C-w>v", { desc = "Split Window Right" })
vim.keymap.set("n", "<leader>tx", "<C-w>q", { desc = "Quit Window" })

-- the "move lines" keybinds use Alt, which would conflict with zellij...
-- I didn't bother with removing the which-key hints for these, since I don't actually know
-- how to make them appear in the first place

vim.keymap.set("v", "N", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "E", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

vim.keymap.set("n", "<cr>", "<cmd>w<cr>")

-- theme

local theme_persistence = require("config.theme_persistence")

vim.keymap.del("n", "<leader>ub")

vim.keymap.set("n", "<leader>ub", theme_persistence.toggle, { desc = "Toggle Background" })
vim.keymap.set("n", "<leader>uB", theme_persistence.update_theme_from_file, { desc = "Update Background From Cache" })

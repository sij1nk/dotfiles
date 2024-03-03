local mu = require("sijink.map_utils")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

mu.kb_aware_map("n", "gh", "^", { desc = "Move to line content beginning" })
mu.kb_aware_map("n", "gH", "0", { desc = "Move to line beginning" })
mu.kb_aware_map("n", "gl", "$", { desc = "Move to line end" })

vim.keymap.set("n", "<leader>c", "<cmd>nohlsearch<cr>", { desc = "Disable search highlights " })
vim.keymap.set({ "n", "v", "x" }, "<leader>a", "maggVG", { desc = "Select all" }) -- 'a to jump back
vim.keymap.set("n", "<leader>==", "maggVG='a", { desc = "Format all naively" }) -- TODO: jump back to exact position
vim.keymap.set("n", "<leader>=f", "<cmd>FormatLock<cr>", { desc = "Format all smartly" }) -- TODO: jump back to exact position
mu.kb_aware_map("n", "J", "mJJ'J", { desc = "Join lines" })
mu.kb_aware_map("n", "n", "nzz", { desc = "Next search result" })
mu.kb_aware_map("n", "N", "Nzz", { desc = "Previous search result" })

-- using <cmd> instead of : does not work here for some reason
mu.kb_aware_map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
mu.kb_aware_map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- keep clipboard when pasting
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste, but keep clipboard" })

-- spellcheck
vim.keymap.set("n", "<leader>SS", "<cmd>set spell!<cr>", { desc = "Toggle spell checking" })

-- saving

vim.keymap.set("n", "<leader>ww", "<cmd>write<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>wa", "<cmd>wall<cr>", { desc = "Write all" })
-- TODO: needs sudo password
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { silent = false, desc = "Sudo write" })

-- TODO: should do 'noh' after done; probably can't be done through keymap.set
vim.keymap.set(
  "n",
  "<leader>vw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]],
  { desc = "sed word" }
)
vim.keymap.set(
  "n",
  "<leader>vW",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gC<Left><Left><Left>]],
  { desc = "sed word with confirm" }
)
vim.keymap.set("n", "<leader>vg", [[:%s//g<Left><Left>]], { desc = "sed" })
vim.keymap.set("n", "<leader>vG", [[:%s//gc<Left><Left>]], { desc = "sed with confirm" })
vim.keymap.set("x", "<leader>vg", [[:s//g<Left><Left>]], { desc = "sed" })
vim.keymap.set("x", "<leader>vG", [[:s//gc<Left><Left>]], { desc = "sed with confirm" })

mu.kb_aware_map("c", "<C-h>", "<Left>", { silent = false })
mu.kb_aware_map("c", "<C-j>", "<Down>", { silent = false })
mu.kb_aware_map("c", "<C-k>", "<Up>", { silent = false })
mu.kb_aware_map("c", "<C-l>", "<Right>", { silent = false })

-- it's necessary to explicitly define these
-- for kb-aware mapping to work
mu.kb_aware_map({ "n", "v", "x" }, "h", "h")
mu.kb_aware_map({ "n", "v", "x" }, "H", "H")
mu.kb_aware_map({ "n", "v", "x" }, "j", "j")
mu.kb_aware_map({ "n", "v", "x" }, "k", "k")
mu.kb_aware_map({ "n", "v", "x" }, "l", "l")
mu.kb_aware_map({ "n", "v", "x" }, "L", "L")
mu.kb_aware_map({ "n", "v", "x" }, "m", "m")
mu.kb_aware_map({ "n", "v", "x" }, "M", "M")
mu.kb_aware_map({ "n", "v", "x" }, "n", "n")
mu.kb_aware_map({ "n", "v", "x" }, "N", "N")
mu.kb_aware_map({ "n", "v", "x" }, "e", "e")
mu.kb_aware_map({ "n", "v", "x" }, "E", "E")
mu.kb_aware_map({ "n", "v", "x" }, "i", "i")
mu.kb_aware_map({ "n", "v", "x" }, "I", "I")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>h", "<C-w>h")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>H", "<C-w>H")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>j", "<C-w>j")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>J", "<C-w>J")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>k", "<C-w>k")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>K", "<C-w>K")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>l", "<C-w>l")
mu.kb_aware_map({ "n", "v", "x" }, "<C-w>L", "<C-w>L")

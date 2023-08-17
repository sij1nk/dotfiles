vim.g.mapleader = ' '

vim.keymap.set('n', 'gh', '^', { desc = "Move to line content beginning" })
vim.keymap.set('n', 'gH', '0', { desc = "Move to line beginning" })
vim.keymap.set('n', 'gl', '$', { desc = "Move to line end" })

vim.keymap.set('n', '<leader>c', '<cmd>nohlsearch<cr>', { desc = "Disable search highlights " })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>a', 'maggVG', { desc = "Select all" }) -- 'a to jump back
vim.keymap.set('n', '<leader>=', "maggVG='a", { desc = "Format all naively" }) -- TODO: jump back to exact position
vim.keymap.set('n', '<leader>f', "<cmd>FormatLock<cr>", { desc = "Format all smartly" }) -- TODO: jump back to exact position
vim.keymap.set('n', "J", "mJJ'J", { desc = "Join lines" })
vim.keymap.set('n', 'n', "nzz", { desc = "Next search result" })
vim.keymap.set('n', 'N', "Nzz", { desc = "Previous search result" })

-- using <cmd> instead of : does not work here for some reason
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- keep clipboard when pasting
vim.keymap.set('x', "<leader>p", "\"_dP", { desc = "Paste, but keep clipboard"})

-- saving
vim.keymap.set('n', '<leader>ww', '<cmd>write<cr>', { desc = "Write"})
vim.keymap.set('n', '<leader>wa', '<cmd>wall<cr>', { desc = "Write all"})
-- TODO: needs sudo password
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %', { silent = false, desc = "Sudo write" })

-- TODO: should do 'noh' after done; probably can't be done through keymap.set
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]], { desc = "sed word" })
vim.keymap.set("n", "<leader>sW", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gC<Left><Left><Left>]],
  { desc = "sed word with confirm" })
vim.keymap.set("n", "<leader>sg", [[:%s//g<Left><Left>]], { desc = "sed" })
vim.keymap.set("n", "<leader>sG", [[:%s//gc<Left><Left>]], { desc = "sed with confirm" })
vim.keymap.set("x", "<leader>sg", [[:s//g<Left><Left>]], { desc = "sed" })
vim.keymap.set("x", "<leader>sG", [[:s//gc<Left><Left>]], { desc = "sed with confirm" })

vim.keymap.set('c', '<C-h>', '<Left>', { silent = false })
vim.keymap.set('c', '<C-j>', '<Down>', { silent = false })
vim.keymap.set('c', '<C-k>', '<Up>', { silent = false })
vim.keymap.set('c', '<C-l>', '<Right>', { silent = false })

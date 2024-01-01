local wk = require("which-key")

wk.register({
  ["<leader>t"] = { name = "Todos" },
})

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

local todo_comments = require("todo-comments")

vim.keymap.set("n", "<leader>tk", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo" })
vim.keymap.set("n", "<leader>tj", function()
  todo_comments.jump_next()
end, { desc = "Next todo" })
vim.keymap.set("n", "<leader>tq", vim.cmd.TodoTrouble, { desc = "List todos in qf" })
vim.keymap.set("n", "<leader>tt", vim.cmd.TodoTelescope, { desc = "List todos" })

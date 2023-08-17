require('Comment').setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
})

local todo_comments = require('todo-comments')

vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous todo"})
vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next todo"})
vim.keymap.set("n", "<leader>?", vim.cmd.TodoTrouble, { desc = "Display todos"})

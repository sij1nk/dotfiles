local wk = require("which-key")

wk.register({
  ["<leader>d"] = {
    name = "Diagnostics",
  },
})

local trouble = require("trouble")

vim.keymap.set("n", "<leader>do", trouble.open, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>dO", function()
  trouble.open("document_diagnostics")
end, { desc = "Show document diagnostics" })

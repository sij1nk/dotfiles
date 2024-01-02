local wk = require("which-key")

wk.register({
  ["<leader>z"] = { name = "Stupid" },
})

vim.keymap.set(
  "n",
  "<leader>zr",
  "<cmd>CellularAutomaton make_it_rain<cr>",
  { desc = "Make it rain" }
)

vim.keymap.set("n", "<leader>zd", function()
  require("duck").hatch()
end, { desc = "Add duck" })

vim.keymap.set("n", "<leader>za", function()
  require("duck").hatch("ඞ")
end, { desc = "Add impostor (from amogus)" })

vim.keymap.set("n", "<leader>zf", function()
  require("duck").hatch("🦀", 42)
end, { desc = "Add Ferris (blazingly fast)" })

vim.keymap.set("n", "<leader>zc", function()
  require("duck").hatch("🐈")
end, { desc = "Add cat" })

vim.keymap.set("n", "<leader>zA", function()
  require("duck").cook()
end, { desc = 'Remove "duck"' })

return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "k", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition" }
    keys[#keys + 1] = { "K", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declaration" }
    keys[#keys + 1] = { "ge", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" }
  end,
}

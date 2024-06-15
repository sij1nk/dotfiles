return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
  opts = {
    cycle_results = false,
  },
  keys = {
    { "<leader>do", "<cmd>Trouble<cr>", desc = "Show diagnostics" },
    { "<leader>dO", "<cmd>Trouble document_diagnostics<cr>", desc = "Show document diagnostics" },
  },
  config = function()
    local wk = require("which-key")

    wk.register({
      ["<leader>d"] = {
        name = "Diagnostics",
      },
    })
  end,
}

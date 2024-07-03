return {
  "rcarriga/nvim-notify",
  enabled = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = { render = "compact" },
  keys = {
    {
      "<leader>uN",
      function()
        local notify = require("notify")
        if vim.tbl_count(notify.history()) == 0 then
          print("There are no notifications to show")
          return
        end
        vim.cmd("Telescope notify")
      end,
      desc = "Show All Notifications",
    },
  },
}

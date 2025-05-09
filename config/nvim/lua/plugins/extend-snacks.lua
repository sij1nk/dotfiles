return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },
    indent = { animate = { enabled = false } },
    picker = {
      sources = {
        files = {
          exclude = { "*.rnote" },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            ["J"] = { "preview_scroll_down", mode = { "n" } },
            ["K"] = { "preview_scroll_up", mode = { "n" } },
            ["H"] = { "preview_scroll_left", mode = { "n" } },
            ["L"] = { "preview_scroll_right", mode = { "n" } },
          },
        },
      },
    },
  },
}

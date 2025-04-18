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
            ["n"] = "list_down",
            ["e"] = "list_up",
          },
        },
        list = {
          keys = {
            ["h"] = "focus_input",
            ["n"] = "list_down",
            ["e"] = "list_up",
          },
        },
        preview = {
          keys = {
            ["h"] = "focus_input",
          },
        },
      },
    },
  },
}

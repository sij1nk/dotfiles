return {
  "snacks.nvim",
  opts = {
    scroll = { enabled = false },
    indent = { animate = { enabled = false } },
    picker = {
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

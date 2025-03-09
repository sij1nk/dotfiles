return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",

      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },
}

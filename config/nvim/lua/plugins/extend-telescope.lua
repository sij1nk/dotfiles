return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><space>",
      LazyVim.pick("auto", { follow = true }),
      desc = "Find Files (Root Dir)",
    },
    { "<leader>ff", LazyVim.pick("auto", { follow = true }), desc = "Find Files (Root Dir)" },
    { "<leader>fF", LazyVim.pick("auto", { follow = true, root = false }), desc = "Find Files (cwd)" },
  },
}

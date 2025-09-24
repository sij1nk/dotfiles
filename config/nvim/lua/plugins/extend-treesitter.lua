return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      {
        "gSj",
        mode = { "n" },
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap Next Parameter",
      },
      {
        "gSk",
        mode = { "n" },
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.outer")
        end,
        desc = "Swap Prev Parameter",
      },
    },
  },
}

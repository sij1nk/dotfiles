return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.textobjects = vim.tbl_extend("force", opts.textobjects, {
        swap = {
          enable = true,
          swap_next = {
            ["gSj"] = { query = "@parameter.inner", desc = "Swap Next Parameter" },
          },
          swap_previous = {
            ["gSk"] = { query = "@parameter.inner", desc = "Swap Prev Parameter" },
          },
        },
      })
    end,
  },
}

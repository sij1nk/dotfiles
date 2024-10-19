return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "xiyaowong/telescope-emoji.nvim",
  },
  keys = {
    {
      "<leader><space>",
      LazyVim.pick("auto", { follow = true }),
      desc = "Find Files (Root Dir)",
    },
    { "<leader>ff", LazyVim.pick("auto", { follow = true }), desc = "Find Files (Root Dir)" },
    { "<leader>fF", LazyVim.pick("auto", { follow = true, root = false }), desc = "Find Files (cwd)" },
  },
  config = function(opts)
    opts = vim.tbl_extend("force", opts, {
      extensions = {
        emoji = {
          action = function(emoji)
            vim.api.nvim_put({ emoji.value }, "c", false, true)
          end,
        },
      },
    })
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("emoji")
  end,
}

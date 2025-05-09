return {
  "hedyhli/outline.nvim",
  opts = {
    symbols = {
      filter = {
        -- TODO: unsure how to get rid of the warning (type hinting it to string[] did not work)
        rust = vim.list_extend(vim.deepcopy(LazyVim.config.kind_filter["default"]), { "Object" }),
      },
    },
  },
}

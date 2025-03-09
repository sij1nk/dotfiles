local function is_wide()
  return vim.o.columns >= 120
end

return {
  "snacks.nvim",
  opts = {
    scroll = { enabled = false },
    indent = { animate = { enabled = false } },
  },
}

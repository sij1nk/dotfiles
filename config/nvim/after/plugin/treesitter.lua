local function treesitter_disable_on_large_buffers(lang, bufnr)
  if #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) > 5000 then
    return true
  end
  return false
end

require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "vimdoc", "bash" },
  sync_install = false,
  auto_install = true,

  autotag = {
    enable = true,
    disable = treesitter_disable_on_large_buffers
  },
  highlight = {
    enable = true,
    disable = treesitter_disable_on_large_buffers,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true,
    disable = treesitter_disable_on_large_buffers
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
})

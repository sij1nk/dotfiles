local M = {}

local cache_filename = "nvim-theme"

local get_cache_filepath = function()
  return os.getenv("XDG_CACHE_HOME") .. "/" .. cache_filename
end

local write_theme_to_file = function(theme)
  local filename = get_cache_filepath()
  local file = io.open(filename, "w+")
  if file == nil then
    print("cannot open theme file for writing")
    return
  end

  file:write(theme .. "\n")
  file:flush()
  M.notify_nvim_instances()
end

M.notify_nvim_instances = function()
  os.execute("pkill -USR1 nvim")
end

M.update_theme_from_file = function()
  local filename = get_cache_filepath()
  local file = io.open(filename)
  if file == nil then
    print("cannot open theme file for reading")
    return
  end

  local theme = file:read()
  if theme ~= "dark" and theme ~= "light" then
    print("read unexpected theme '" .. theme .. "' from theme file; defaulting to 'dark'")
    theme = "dark"
  end
  vim.opt.bg = theme
end

M.toggle = function()
  local current = vim.opt.bg:get()
  local next
  if current == "dark" then
    next = "light"
  else
    next = "dark"
  end
  vim.opt.bg = next
  write_theme_to_file(next)
end

vim.api.nvim_create_autocmd("Signal", {
  group = vim.api.nvim_create_augroup("UpdateTheme", {}),
  pattern = "SIGUSR1",
  callback = M.update_theme_from_file,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("UpdateTheme", {}),
  pattern = "nvim-theme",
  callback = function()
    M.update_theme_from_file()
    M.notify_nvim_instances()
  end,
})

return M

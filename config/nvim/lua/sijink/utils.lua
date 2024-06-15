local M = {}

M.env_or_default = function(env_var, default_value)
  local value = os.getenv(env_var)
  if value == nil then
    return default_value
  else
    return value
  end
end

return M

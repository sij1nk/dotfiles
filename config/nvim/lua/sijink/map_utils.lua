-- TODO: dream scenario:
-- whenever the KYRIA env var changes, vim automatically unsets
-- conflicting keymaps between qwerty and c-dh, and sets the keymaps
-- which are appropriate for the newly selected layout
--
-- for now, neovim needs to be restarted for the changes to take
-- effect
local M = {}

local kyria_remaps = {
  i = "h",
  m = "j",
  n = "k",
  e = "l",
  h = "m",
  j = "n",
  k = "e",
  l = "i",
}

local kyria = nil
local kyria_env = os.getenv("KYRIA")
if kyria_env ~= nil and tonumber(kyria_env) > 0 then
  kyria = true
else
  kyria = false
end

local function dump(thing)
  if type(thing) == "table" then
    local str = "{"
    local index = 0
    local len = vim.tbl_count(thing)
    for i, v in pairs(thing) do
      index = index + 1
      if type(i) == "string" then
        str = str .. i .. " = "
      end
      str = str .. tostring(dump(v))
      if index < len then
        str = str .. ", "
      end
    end
    return str .. "}"
  elseif type(thing) == "string" then
    return "'" .. tostring(thing) .. "'"
  else
    return thing
  end
end

local function phony_keymap_set(mode, lhs, rhs, opts)
  print(
    string.format("vim.keymap.set(%s, %s, %s, %s)", dump(mode), dump(lhs), dump(rhs), dump(opts))
  )
end

local function transform_lhs(lhs, remap_modifiers)
  local replace_start_index = nil
  if remap_modifiers then
    -- assuming that:
    -- <leader> is always at the beginning
    -- up to 1 modifier-ed key
    local _, dash_end = string.find(lhs, "-")
    if dash_end then
      replace_start_index = dash_end + 1
    else
      local _, leader_end = string.find(string.lower(lhs), "<leader>")
      if leader_end then
        replace_start_index = leader_end + 1
      end
    end
  else
    replace_start_index = select(2, string.find(lhs, ">"))
  end

  if not replace_start_index then
    replace_start_index = 1
  end

  local prefix = string.sub(lhs, 1, replace_start_index - 1)
  local rest = string.sub(lhs, replace_start_index)

  local rest_transformed = ""
  for c in string.gmatch(rest, ".") do
    local c_transformed = nil
    if not kyria_remaps[c] then
      local c_lower = string.lower(c)
      if not kyria_remaps[c_lower] then
        c_transformed = c
      else
        c_transformed = string.upper(kyria_remaps[c_lower])
      end
    else
      c_transformed = kyria_remaps[c]
    end
    rest_transformed = rest_transformed .. c_transformed
  end

  return prefix .. rest_transformed
end

M.transform_mapping_table = function(table, opts)
  if not kyria then
    return table
  end

  local remap_modifiers = opts and opts.remap_modifiers or false

  local ret = {}
  for lhs, rhs in pairs(table) do
    ret[transform_lhs(lhs, remap_modifiers)] = rhs
  end

  return ret
end

M.kb_aware_map = function(mode, lhs, rhs, opts)
  if not kyria then
    vim.keymap.set(mode, lhs, rhs, opts)
    return
  end

  local remap_modifiers = opts and opts.remap_modifiers or false

  vim.keymap.set(mode, transform_lhs(lhs, remap_modifiers), rhs, opts)
end

return M

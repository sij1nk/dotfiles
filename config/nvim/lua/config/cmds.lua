vim.api.nvim_create_user_command("StripWhitespace", ":%s/\\s\\+$//c", {})

local empty_template_path = vim.env.HOME .. "/Notes/_empty_template.rnote"

-- TODO:
-- - insert link
-- - proper doc comments
-- - eventually extract into plugin
-- - if it becomes a plugin, we can depend on plenary.log to properly log errors and stuff
function NeorgInsertRnoteLink()
  local bufname = vim.api.nvim_buf_get_name(0)
  if string.len(bufname) == 0 then
    vim.notify("Current buffer must point to a file on disk", vim.log.levels.ERROR)
    return
  end

  vim.ui.input({ prompt = "Enter rnote filename (without file extension)" }, function(text)
    if not text then
      return
    end

    local buf_dirname = vim.fs.dirname(bufname)

    local rnote_filepath = vim.fs.joinpath(buf_dirname, text .. ".rnote")
    print("filename: " .. rnote_filepath)

    if not vim.uv.fs_stat(rnote_filepath) then
      -- rnote cannot open a file which does not exist, so we must create it ourselves
      local result = vim.system({ "cp", empty_template_path, rnote_filepath }):wait()
      if result.code ~= 0 then
        print("Failed to initialize rnote file! Error: " .. result.stderr)
        return
      end
    end

    vim.system({ "rnote", rnote_filepath }, { cwd = buf_dirname })

    -- insert neorg link at current cursor position
    vim.api.nvim_put({ "{file://" .. rnote_filepath .. "}[" .. text .. "]" }, "c", true, true)
  end)
end

vim.api.nvim_create_user_command("NeorgInsertRnoteLink", NeorgInsertRnoteLink, {})

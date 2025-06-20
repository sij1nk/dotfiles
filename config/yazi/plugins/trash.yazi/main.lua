local selected_or_hovered = ya.sync(function()
  local tab, paths = cx.active, {}
  for _, u in pairs(tab.selected) do
    paths[#paths + 1] = tostring(u)
  end
  if #paths == 0 and tab.current.hovered then
    paths[1] = tostring(tab.current.hovered.url)
  end
  return paths
end)

local function entry()
  ya.emit("escape", { visual = true })
  local selected = selected_or_hovered()
  local answer = ya.confirm({
    pos = { "center", w = 70, h = 20 },
    title = string.format("Trash %d selected files?", #selected),
    content = ui.Text(table.concat(selected, "\n")):wrap(ui.Wrap.YES),
  })
  if answer then
    Command("trash-put"):arg(selected):status()
  end
end

return { entry = entry }

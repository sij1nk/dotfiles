local wsl = vim.fn.has('wsl')

if wsl then
  vim.o.clipboard = "unnamedplus"

  vim.g.clipboard = {
    copy = {
      ["+"] = [[win32yank -i --crlf]],
      ["*"] = [[win32yank -i --crlf]],
    },
    paste = {
      ["+"] = [[win32yank -o --lf]],
      ["*"] = [[win32yank -o --lf]],
    },
  }
end

vim.api.nvim_create_user_command("StripWhitespace", ":%s/\\s\\+$//c", {})

return {
  url = "https://codeberg.org/trevorhauter/gitportal.nvim",
  lazy = false,
  opts = {
    browser_command = "firefox.exe",
    git_provider_map = { ["code.siemens.com:"] = { provider = "gitlab", base_url = "https://code.siemens.com/" } },
  },
  keys = {
    { "<leader>gp", "<cmd>GitPortal<cr>", desc = "Open in Git forge", mode = { "n", "v" } },
    { "<leader>gP", "<cmd>GitPortal clip_remote<cr>", desc = "Copy Git forge link", mode = { "n", "v" } },
  },
}

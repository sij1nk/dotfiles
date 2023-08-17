local telescope = require('telescope')
local themes = require('telescope.themes')

telescope.setup({
  prompt_prefix=" ", -- TODO: does not work
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    },
    ["ui-select"] = {
      themes.get_dropdown({
      })
    }
  }
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function()
    builtin.find_files({
      find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }
    })
  end,
  { desc = "Telescope" }
)
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set('n', '<leader>G', builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set('n', '<leader>hm', builtin.man_pages, { desc = "Telescope: Man pages" })
vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = "Telescope: Help tags" })
vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Telescope: Git commits" })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = "Telescope: Git buffer commits" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Telescope: Git branches" })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Telescope: Git status" })

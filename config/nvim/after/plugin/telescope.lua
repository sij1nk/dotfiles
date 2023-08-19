local mu = require('sijink.map_utils')

local telescope = require('telescope')
local themes = require('telescope.themes')

-- NOTE: we need to explicitly define mappings which conflict between qwerty and c-dh
local mappings = {
  i = mu.transform_mapping_table({
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
  }, { remap_modifiers = true }),
  n = mu.transform_mapping_table({
      ["j"] = "move_selection_next",
      ["k"] = "move_selection_previous",
      ["H"] = "move_to_top",
      ["M"] = "move_to_middle",
      ["L"] = "move_to_bottom",
  }, { remap_modifiers = true })
}

telescope.setup({
  defaults = {
    prompt_prefix=" ",
    mappings = mappings,
  },
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
mu.kb_aware_map('n', '<leader>hm', builtin.man_pages, { desc = "Telescope: Man pages" })
mu.kb_aware_map('n', '<leader>hh', builtin.help_tags, { desc = "Telescope: Help tags" })
mu.kb_aware_map('n', '<leader>hk', builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Telescope: Git commits" })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = "Telescope: Git buffer commits" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Telescope: Git branches" })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Telescope: Git status" })

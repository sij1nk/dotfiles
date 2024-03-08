local mu = require("sijink.map_utils")

require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    same_level = true,
    insert_as = "sibling",
    mappings = mu.transform_mapping_table({
      ["<cr>"] = "open_with_window_picker",
      ["l"] = "open_with_window_picker",
      ["h"] = "close_node",
      ["k"] = "none",
      ["m"] = "move",
      ["e"] = "toggle_auto_expand_width",
    }),
  },
  filesystem = {
    group_empty_dirs = true,
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
    },
    follow_current_file = {
      enabled = true,
    },
  },
})

mu.kb_aware_map("n", "<C-h>", "<cmd>Neotree toggle left<cr>", { desc = "File tree" })

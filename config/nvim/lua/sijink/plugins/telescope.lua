local mu = require("sijink.map_utils")

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  keys = {
    {
      "<C-p>",
      function()
        local builtin = require("telescope.builtin")

        builtin.find_files({
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          follow = true,
        })
      end,
      { desc = "Telescope" },
    },
    { "<leader>gg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope: Live grep" } },
    { "<leader>gG", "<cmd>Telescope grep_string<cr>", { desc = "Telescope: Grep string" } },
    { "<leader>gm", "<cmd>Telescope man_pages<cr>", { desc = "Telescope: Man pages" } },
    { "<leader>gh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope: Help tags" } },
    { "<leader>gk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope: Keymaps" } },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope: Git commits" } },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Telescope: Git buffer commits" } },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope: Git branches" } },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Telescope: Git status" } },
  },
  opts = function()
    local themes = require("telescope.themes")

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
      }, { remap_modifiers = true }),
    }
    return {
      defaults = {
        prompt_prefix = " ",
        mappings = mappings,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          themes.get_dropdown({}),
        },
      },
    }
  end,
  config = function(opts)
    local telescope = require("telescope")

    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local wk = require("which-key")

    wk.register({
      ["<leader>g"] = {
        name = "Telescope",
      },
    })
  end,
}

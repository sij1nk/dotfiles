local wk = require("which-key")

wk.register({
  ["<leader>i"] = {
    name = "Iselect",
  },
  ["gs"] = {
    name = "Swap",
  },
})

local function treesitter_disable_on_large_buffers(lang, bufnr)
  if #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) > 5000 then
    return true
  end
  return false
end

vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vimdoc", "bash" },
  sync_install = false,
  auto_install = true,

  autotag = {
    enable = true,
    disable = treesitter_disable_on_large_buffers,
  },
  highlight = {
    enable = true,
    disable = treesitter_disable_on_large_buffers,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = treesitter_disable_on_large_buffers,
  },
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ii",
      node_incremental = "<leader>ij",
      scope_incremental = "<leader>is",
      node_decremental = "<leader>ik",
    },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select around function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },
        ["ac"] = { query = "@class.outer", desc = " Select around class region" },
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["gsj"] = "@parameter.inner",
      },
      swap_previous = {
        ["gsk"] = "@parameter.inner",
      },
    },
  },
})

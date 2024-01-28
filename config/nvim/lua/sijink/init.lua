require("sijink.map")
require("sijink.options")
require("sijink.clipboard")

local function env_or_default(env_var, default_value)
  local value = os.getenv(env_var)
  if value == nil then
    return default_value
  else
    return value
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local notes_path = env_or_default("NEORG_NOTES_WORKSPACE_DIR", "~/Notes")
local worknotes_path = env_or_default("NEORG_WORKNOTES_WORKSPACE_DIR", "~/Worknotes")

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- for JSX/TSX comments (and possibly in similar embedded languages)
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    -- automatically insert closing parens, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  { "windwp/nvim-ts-autotag" }, -- automatically close and rename HTML tags
  { "numToStr/Comment.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        -- select which split to open a file in, if there are multiple
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            selection_chars = "tnseriao",
          })
        end,
      },
    },
  },
  { "NvChad/nvim-colorizer.lua" }, -- visualize color(code)s
  { "mbbill/undotree" },
  {
    -- highlight same words as word under cursor
    "echasnovski/mini.cursorword",
    version = "*",
    config = function()
      require("mini.cursorword").setup({
        delay = 50,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  { "mhartington/formatter.nvim" },

  -- COMPLETIONS
  { "hrsh7th/nvim-cmp" }, -- completion engine
  { "hrsh7th/cmp-buffer" }, -- buffer completions
  { "hrsh7th/cmp-path" }, -- path completions
  { "hrsh7th/cmp-cmdline" }, -- cmdline completions
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP completions
  { "hrsh7th/cmp-calc" },
  {
    -- snippet completions
    "saadparwaiz1/cmp_luasnip",
    dependencies = {
      {
        -- snippet engine
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
    },
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  { "mfussenegger/nvim-lint" },
  { "simrat39/rust-tools.nvim" }, -- some extra goodies necessary for Rust LSP
  {
    -- extra goodies for typescript
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  { "folke/neodev.nvim" }, -- LSP stuff for the neovim API
  { "b0o/schemastore.nvim" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      cycle_results = false,
    },
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = { text = { spinner = "earth" }, max_messages = 3 }, -- TODO: max_messages unimpl
  },

  -- Stupid
  { "eandrju/cellular-automaton.nvim" },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    enabled = false,
    opts = {
      screensaver = 1000 * 60 * 5, -- 5 minutes
      filetypes = { "*" },
    },
  },
  { "tamton-aquib/duck.nvim" },

  { "danymat/neogen", dependencies = "nvim-treesitter/nvim-treesitter", config = true },

  { "folke/neodev.nvim", opts = {} },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim", { "nvim-neorg/neorg-telescope" } },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = notes_path,
                worknotes = worknotes_path,
              },
              default_workspace = "notes",
            },
          },
          ["core.ui.calendar"] = {},
          ["core.integrations.telescope"] = {},
          ["core.esupports.metagen"] = {},
        },
      })
    end,
  },
})

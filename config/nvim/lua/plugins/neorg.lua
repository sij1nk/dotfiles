local function env_or_default(env_var, default_value)
  local value = os.getenv(env_var)
  if value == nil then
    return default_value
  else
    return value
  end
end

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  { "benlubas/neorg-conceal-wrap" },
  { "juniorsundar/neorg-extras" },
  {
    "nvim-neorg/neorg",
    version = "*",
    ft = "norg",
    dependencies = {
      "vhyrro/luarocks.nvim",
      "nvim-lua/plenary.nvim",
      "benlubas/neorg-conceal-wrap",
      "benlubas/neorg-interim-ls",
    },
    keys = {
      { "<C-l>", "<cmd>Neorg roam node<cr>", desc = "List Neorg notes", mode = { "n", "i" }, ft = "norg" },
      { "<C-b>", "<cmd>Neorg roam block<cr>", desc = "List Neorg blocks", mode = { "n", "i" }, ft = "norg" },
      { "<C-r>", "<cmd>NeorgInsertRnoteLink<cr>", desc = "Insert Rnote link", mode = { "n", "i" }, ft = "norg" },
      { "gd", "<Plug>(neorg.esupports.hop.hop-link)", desc = "[neorg] Jump to Link", mode = "n", ft = "norg" },
    },
    config = function()
      local notes_path = env_or_default("NEORG_NOTES_WORKSPACE_DIR", "~/Notes")
      local worknotes_path = env_or_default("NEORG_WORKNOTES_WORKSPACE_DIR", "~/Worknotes")
      require("neorg").setup({
        load = {
          ["core.defaults"] = {
            config = {
              disable = {
                "core.todo-introspector",
              },
            },
          }, -- Loads default behaviour
          ["core.completion"] = {
            config = { engine = { module_name = "external.lsp-completion" } },
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
              icons = {
                code_block = {
                  conceal = true,
                },
              },
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
          ["core.export"] = {
            config = {
              export_dir = "<export-dir>/<language>-export",
            },
          },
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
          ["core.ui.calendar"] = {},
          ["core.esupports.metagen"] = {
            config = {
              type = "auto",
              -- TODO: include weekday name (%A)
            },
          },
          ["external.conceal-wrap"] = {},
          ["external.many-mans"] = {
            config = {
              metadata_fold = true, -- If want @data property ... @end to fold
              code_fold = true, -- If want @code ... @end to fold
            },
          },
          ["external.roam"] = {
            config = {
              fuzzy_finder = "Snacks", -- OR "Fzf" OR "Snacks". Defaults to "Telescope"
              fuzzy_backlinks = true, -- Set to "true" for backlinks in fuzzy finder instead of buffer
              roam_base_directory = "", -- Directory in current workspace to store roam nodes
              node_name_randomiser = false, -- Tokenise node name suffix for more randomisation
              node_name_snake_case = false, -- snake_case the names if node_name_randomiser = false
            },
          },
          ["external.interim-ls"] = {},
        },
      })

      -- this is to fix bug: https://github.com/folke/which-key.nvim/issues/476
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Set up neorg Which-Key descriptions",
        group = vim.api.nvim_create_augroup("neorg_mapping_descriptions", { clear = true }),
        pattern = "norg",
        callback = function()
          vim.keymap.set("n", "<localleader>", function()
            require("which-key").show(",")
          end, { buffer = true })
        end,
      })
    end,
  },
}

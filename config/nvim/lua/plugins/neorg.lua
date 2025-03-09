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
  {
    "nvim-neorg/neorg",
    version = "*",
    ft = "norg",
    dependencies = {
      "vhyrro/luarocks.nvim",
      "nvim-lua/plenary.nvim",
      "benlubas/neorg-conceal-wrap",
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
            config = {
              engine = "nvim-cmp",
            },
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
        },
      })

      local neorg_callbacks = require("neorg.core.callbacks")

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

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "neorg" })
    end,
  },
}

local neorg_callbacks = require("neorg.core.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  -- Map all the below keybinds only when the "norg" mode is active
  keybinds.map_event_to_mode("norg", {
    n = { -- Bind keys in normal mode
      { "<localleader>ll", "core.integrations.telescope.insert_file_link" },
      { "<localleader>lf", "core.integrations.telescope.insert_link" },
    },

    i = { -- Bind in insert mode
      { "<C-l>", "core.integrations.telescope.insert_file_link" },
      { "<C-f>", "core.integrations.telescope.insert_link" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)

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

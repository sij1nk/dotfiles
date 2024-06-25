return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      local opts = {
        styles = {
          transparency = true,
        },
        dark_variant = "main",
        dim_nc_background = true, -- nc ~ non-current windows
        disable_italics = false, -- italics are only an issue on WSL + Zellij + Windows Terminal

        groups = { -- TODO
          background = "surface",
          border = "muted",
        },

        highlight_groups = {
          Cursor = { bg = "subtle", fg = "text" }, -- handled by the terminal emulator; might not do anything
          CursorLine = { bg = "highlight_low" },
          NeoTreeRootName = { bg = "surface", fg = "iris", bold = true },
          WindowPickerStatusLineNC = { bg = "pine", fg = "base" },
          Pmenu = { bg = "base" },
          PmenuSel = { bg = "foam", fg = "base" },
          CmpItemMenu = { fg = "highlight_high" },
          CmpItemKindText = { fg = "rose" },
          -- TODO: highlights for more kinds
          WhichKeyFloat = { bg = "overlay" },
          NormalFloat = { bg = "overlay", fg = "text" },
          FloatBorder = { bg = "overlay", fg = "overlay" },
          TelescopeNormal = { bg = "base" },
          TelescopeBorder = { bg = "base", fg = "base" },
          TelescopePreviewNormal = { bg = "base" },
          TelescopePreviewBorder = { bg = "base", fg = "base" },
          TelescopePromptNormal = { bg = "surface" },
          TelescopePromptBorder = { bg = "surface", fg = "surface" },
          TelescopePromptTitle = { bg = "surface", fg = "surface" },
          TelescopePreviewTitle = { bg = "love", fg = "base" },
          TelescopeResultsTitle = { bg = "base", fg = "base" },
          TelescopeSelection = { bg = "foam", fg = "base" },
          TelescopeSelectionCaret = { bg = "foam", fg = "foam" },
          TelescopePromptPrefix = { fg = "text" }, -- TODO: doesn't work?
          MyHighlight = { fg = "iris" },
          IblIndent = { fg = "highlight_med" },
          CodeBlock = { bg = "base" },
          -- rose-pine italicizes a lot of stuff by default, which is annoying with fancy italic fonts
          ["@variable"] = { fg = "text", italic = false },
          ["@parameter"] = { fg = "iris", italic = false },
          ["@property"] = { fg = "foam", italic = false },
          ["@constant"] = { fg = "gold", bold = true, italic = true },
          ["@constant.macro"] = { fg = "love" },
          LspInlayHint = { fg = "highlight_med", bg = "base", blend = 10, italic = true },
        },
      }

      for i = 1, 6 do
        opts.highlight_groups["Headline" .. i] = { bg = "overlay" }
      end
      opts.highlight_groups["Headline"] = { link = "Headline1" }

      require("rose-pine").setup(opts)
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}

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
          WindowPickerStatusLineNC = { bg = "pine", fg = "base" },
          Pmenu = { bg = "base" },
          PmenuSel = { bg = "foam", fg = "base" },
          CmpItemMenu = { fg = "highlight_high" },
          CmpItemKindText = { fg = "rose" },
          WhichKeyFloat = { bg = "overlay" },
          NormalFloat = { bg = "base", fg = "text" },
          FloatBorder = { bg = "base", fg = "base" },
          MyHighlight = { fg = "iris" },
          IblIndent = { fg = "highlight_med" },
          CodeBlock = { bg = "base" },
          -- rose-pine italicizes a lot of stuff by default, which is annoying with fancy italic fonts
          ["@variable"] = { fg = "text", italic = false },
          ["@parameter"] = { fg = "iris", italic = false },
          ["@property"] = { fg = "foam", italic = false },
          ["@constant"] = { fg = "gold", bold = true, italic = true },
          ["@constant.macro"] = { fg = "love" },
          ["@neorg.markup.verbatim"] = { bg = "highlight_low" },
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

vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.fillchars = "vert: ,eob: "

require('colorizer').setup({
  filetypes = { "lua", "html", "css", "scss" },
  mode = "virtualtext"
})

require('rose-pine').setup({
  dark_variant = "main",
  dim_nc_background = true, -- nc ~ non-current windows
  disable_italics = false, -- italics are only an issue on WSL + Zellij + Windows Terminal

  groups = { -- TODO
    background = 'surface',
    border = 'muted',
  },

  highlight_groups = {
    Cursor = { bg = "highlight_high", fg = "text" }, -- handled by the terminal emulator; might not do anything
    CursorLine = { bg = 'highlight_low' },
    StatusLine = { bg = "rose", fg = "base" },
    NeoTreeRootName = { bg = "surface", fg = "iris", bold = true },
    WindowPickerStatusLineNC = { bg = "pine", fg = "base" },
    MiniCursorword = { bg = "highlight_low" },
    LspReferenceText = { bg = "gold" },
    LspReferenceRead = { bg = "pine" },
    LspReferenceWrite = { bg = "iris" },
    Pmenu = { bg = "base" },
    PmenuSel = { bg = "foam", fg = "base"},
    CmpItemMenu = { fg = "highlight_high" },
    CmpItemKindText = { fg = "rose" },
    -- TODO: highlights for more kinds
    WhichKeyFloat = { bg = "overlay"},
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
    ['@variable'] = { fg = "text", italic = false },
    ['@parameter'] = { fg = "iris", italic = false },
    ['@property'] = { fg = "iris", italic = false },
  }
})

vim.cmd.colorscheme('rose-pine')

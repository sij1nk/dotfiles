local mu = require("sijink.map_utils")

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menuone,noinsert,noselect"

local icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local select_behavior = { behavior = cmp.SelectBehavior.Select }
local confirm_behavior = {
  behavior = cmp.ConfirmBehavior.Insert,
  select = false,
}

cmp.setup({
  mapping = mu.transform_mapping_table({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(select_behavior)
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping.select_next_item(select_behavior),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_behavior)
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping.select_prev_item(select_behavior),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item(select_behavior)
          if #cmp.get_entries() == 1 then
            cmp.confirm(confirm_behavior)
          end
        else
          cmp.confirm(confirm_behavior)
        end
      else
        fallback()
      end
    end, { "i", "s", "c" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Esc>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      end
      fallback()
    end),
  }, { remap_modifiers = true }),
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "calc" },
  },
  formatting = {
    -- fields = { "abbr", "kind", "menu" },
    fields = { "abbr", "kind", "menu" }, -- menu ~ source

    format = function(entry, item)
      item.kind = string.format("%s %s", icons[item.kind], item.kind)
      item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        calc = "[Calc]"
      })[entry.source.name]
      return item
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered()
    -- documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = { hl_group = "NonText" }, -- TODO: ghost text doesn't work?
  },
})

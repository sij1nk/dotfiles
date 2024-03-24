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

local lspkind_comparator = function(conf)
  local lsp_types = require("cmp.types").lsp
  return function(entry1, entry2)
    if entry1.source.name ~= "nvim_lsp" then
      if entry2.source.name == "nvim_lsp" then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

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
    { name = "nvim_lsp", priority = 0 },
    { name = "neorg", priority = 0 },
    { name = "buffer", priority = 5 },
    { name = "path", priority = 5 },
    { name = "luasnip", priority = 10 },
    { name = "calc", priority = 20 },
  },
  sorting = {
    comparators = {
      lspkind_comparator({
        kind_priority = {
          Field = 11,
          Property = 11,
          Constant = 10,
          Enum = 10,
          EnumMember = 10,
          Event = 10,
          Function = 10,
          Method = 10,
          Operator = 10,
          Reference = 10,
          Struct = 10,
          Variable = 9,
          File = 8,
          Folder = 8,
          Class = 5,
          Color = 5,
          Module = 5,
          Keyword = 2,
          Constructor = 1,
          Interface = 1,
          Snippet = 0,
          Text = 1,
          TypeParameter = 1,
          Unit = 1,
          Value = 1,
        },
      }),
    },
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
        calc = "[Calc]",
        neorg = "[Neorg]",
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

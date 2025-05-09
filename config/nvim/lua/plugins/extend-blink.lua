return {
  "saghen/blink.cmp",
  dependencies = {
    "disrupted/blink-cmp-conventional-commits",
    "bydlw98/blink-cmp-env",
    "moyiz/blink-emoji.nvim",
  },
  opts = {
    completion = {
      trigger = {
        show_in_snippet = false,
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
    },
    sources = {
      compat = {},
      default = {
        "conventional_commits",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "env",
        "emoji",
      },
      providers = {
        conventional_commits = {
          name = "Conventional Commits",
          module = "blink-cmp-conventional-commits",
          enabled = function()
            return vim.bo.filetype == "gitcommit"
          end,
        },
        env = {
          name = "Env",
          module = "blink-cmp-env",
          score_offset = -5,
          --- @type blink-cmp-env.Options
          opts = {
            item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
            show_braces = false,
            show_documentation_window = true,
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        },
      },
    },
    keymap = {
      preset = "enter",

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_next()
          end
        end,
        "snippet_forward",
        "fallback",
      },

      ["<S-Tab>"] = {
        function(cmp)
          if not cmp.snippet_active() then
            return cmp.select_prev()
          end
        end,
        "snippet_backward",
        "fallback",
      },

      ["<CR>"] = { "accept", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      ["<ESC>"] = {
        -- cancel completion and go back to Normal mode
        function(cmp)
          if cmp.is_visible() then
            cmp.cancel()
            -- Esc must be scheduled, to ensure that the cursor is in the correct buffer when the cancel (which is also scheduled) undos the cmp preview
            vim.schedule(function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
            end)
            return true
          end
        end,
        "fallback",
      },
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = "inherit",

        ["<ESC>"] = {
          -- cancel completion, but don't close cmdline
          function(cmp)
            if cmp.is_visible() then
              cmp.cancel()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
            end
          end,
        },
      },
      completion = { menu = { auto_show = true } },
      sources = { "path" },
    },
  },
}

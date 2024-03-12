local mu = require("sijink.map_utils")

require("neodev").setup()

local lsp = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local schemastore = require("schemastore")
local telescope = require("telescope.builtin")
local tstools_api = require("typescript-tools.api")

local function set_diagnostic_keymaps(bufnr)
  vim.keymap.set(
    "n",
    "<leader>dd",
    "<cmd>lua vim.diagnostic.open_float()<cr>",
    { buffer = bufnr, desc = "Show diagnostic details" }
  )
  vim.keymap.set(
    "n",
    "<leader>dk",
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    { buffer = bufnr, desc = "Go to previous diagnostic" }
  )
  vim.keymap.set(
    "n",
    "<leader>dj",
    "<cmd>lua vim.diagnostic.goto_next()<cr>",
    { buffer = bufnr, desc = "Go to next diagnostic" }
  )
end

local function on_attach(client, bufnr)
  vim.b.minicursorword_disable = true

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.server_capabilities.documentHighlight then
    vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end

  vim.keymap.set(
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<cr>",
    { buffer = bufnr, desc = "Go to definition" }
  )
  vim.keymap.set(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<cr>",
    { buffer = bufnr, desc = "Go to declaration" }
  )
  mu.kb_aware_map("n", "gi", function()
    telescope.lsp_implementations({ show_line = false })
  end, { buffer = bufnr, desc = "Go to implementation" })
  vim.keymap.set("n", "gr", function()
    telescope.lsp_references({ show_line = false })
  end, { buffer = bufnr, desc = "Go to references" })
  mu.kb_aware_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr, desc = "Hover" })
  mu.kb_aware_map(
    { "n", "i" },
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
    { buffer = bufnr, desc = "Signature help" }
  )
  vim.keymap.set(
    "n",
    "<leader>r",
    "<cmd>lua vim.lsp.buf.rename()<cr>",
    { buffer = bufnr, desc = "Rename" }
  )
  vim.keymap.set(
    "n",
    "<leader>s",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { buffer = bufnr, desc = "Code actions" }
  )
  set_diagnostic_keymaps(bufnr)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "jsonls" },
  automatic_installation = true,
  handlers = {
    function(server_name)
      lsp[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
    end,
    ["lua_ls"] = function()
      lsp.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            format = {
              enable = true,
            },
            workspaces = {
              checkThirdParty = false,
            },
            telemetry = {
              enabled = false,
            },
          },
        },
      })
    end,
    ["tsserver"] = function()
      require("typescript-tools").setup({
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = {
          -- ignore no-unused-vars error; handled by eslint instead
          ["textDocument/publishDiagnostics"] = tstools_api.filter_diagnostics({ 6133 }),
        },
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = {},
          tsserver_path = nil, -- use standard path resolution
          tsserver_plugins = {},
          tsserver_max_memory = "auto",
          tsserver_format_options = {},
          tsserver_file_preferences = {},
          complete_function_calls = false,
        },
      })
    end,
    ["jsonls"] = function()
      lsp.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = schemastore.json.schemas({
              select = {
                "package.json",
              },
            }),
            validate = { enable = true },
          },
        },
      })
    end,
    ["yamlls"] = function()
      lsp.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = schemastore.yaml.schemas(),
          },
        },
      })
    end,
  },
})

local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = { active = diagnostic_signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
  focusable = true, -- especially Rust tends to have really long hover docs
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
  focusable = false,
})

local lint = require("lint")
lint.linters_by_ft = vim.tbl_extend("keep", lint.linters_by_ft, {
  javascript = {
    "eslint_d",
  },
  typescript = {
    "eslint_d",
  },
  javascriptreact = {
    "eslint_d",
  },
  typescriptreact = {
    "eslint_d",
  },
  -- TODO: no worky?
  markdown = {
    "markdownlint",
  },
  sh = {
    "shellcheck",
  },
})

local markdownlint = lint.linters.markdownlint
-- MD024: allow multiple headings with the same content
markdownlint.args = {
  "--disable MD024 --",
}

vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("Lint", {}),
  pattern = "*",
  callback = function(args)
    if not vim.tbl_get(lint.linters_by_ft, vim.bo.filetype) then
      return
    end

    set_diagnostic_keymaps(args.buf)
    lint.try_lint()
  end,
})

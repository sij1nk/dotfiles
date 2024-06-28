return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    opts.server = vim.tbl_extend("force", opts.server, {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
        vim.keymap.set("n", "<leader>ce", function()
          vim.cmd.RustLsp("explainError")
        end, { desc = "Explain Rust Error", buffer = bufnr })
      end,
    })

    opts.tools = {
      float_win_config = {
        auto_focus = true,
      },
    }
  end,
}

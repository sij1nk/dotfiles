return {
  "nvim-neotest/neotest",
  keys = function()
    return {
      { "<leader>w", "", desc = "+test" },
      {
        "<leader>wt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File (Neotest)",
      },
      {
        "<leader>wT",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Run All Test Files (Neotest)",
      },
      {
        "<leader>wr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest (Neotest)",
      },
      {
        "<leader>wl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last (Neotest)",
      },
      {
        "<leader>ws",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary (Neotest)",
      },
      {
        "<leader>wo",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output (Neotest)",
      },
      {
        "<leader>wO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel (Neotest)",
      },
      {
        "<leader>wS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop (Neotest)",
      },
      {
        "<leader>ww",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle Watch (Neotest)",
      },
    }
  end,
}

return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tv", "", desc = "+vim-test" },
      { "<leader>tvl", "<cmd>TestLast<cr>", desc = "Run last" },
      { "<leader>tvr", "<cmd>TestNearest<cr>", desc = "Run nearest" },
      { "<leader>tvt", "<cmd>TestFile<cr>", desc = "Run file" },
      { "<leader>tvT", "<cmd>TestSuite<cr>", desc = "Run suite" },
      { "<leader>tvv", "<cmd>TestVisit<cr>", desc = "Visit last" },
    },
    dependencies = { "preservim/vimux" },
    config = function()
      vim.cmd("let test#strategy = 'vimux'")
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-python",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
        end,
      },
    },
    keys = {
      -- stylua: ignore start
      {"<leader>t", "", desc = "+test"},
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run all test files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle watch" },
      -- stylua: ignore end
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            jestArguments = function(defaultArguments)
              return defaultArguments
            end,
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
          require("neotest-golang")({
            runner = "gotestsum",
            go_test_args = { "-v", "-race", "-count=1" },
            dap_go_enabled = true,
          }),
          require("neotest-python"),
          require("neotest-bash"),
        },
      })
    end,
  },
}

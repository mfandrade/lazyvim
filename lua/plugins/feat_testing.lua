return {
  {
    "vim-test/vim-test",
    -- dependencies = { "preservim/vimux" },
    keys = {
      { "<leader>Tl", "<cmd>TestLast<cr>", desc = "vim-test Last" },
      { "<leader>Tr", "<cmd>TestNearest<cr>", desc = "vim-test Nearest" },
      { "<leader>Tt", "<cmd>TestFile<cr>", desc = "vim-test File" },
      { "<leader>TT", "<cmd>TestSuite<cr>", desc = "vim-test Suite" },
      -- { "<leader>Tv", "<cmd>TestVisit<cr>",  desc = "vim-test Visit" },
    },
    config = function()
      vim.cmd("let test#strategy = 'neovim'")
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-python",
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
          require("neotest-python"),
        },
      })
    end,
  },
}

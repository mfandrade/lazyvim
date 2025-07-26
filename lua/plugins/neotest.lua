return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tr", "<cmd>Neotest run<cr>" },
    { "<leader>to", "<cmd>Neotest output<cr>" },
    { "<leader>ts", "<cmd>Neotest summary<cr>" },
    { "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}

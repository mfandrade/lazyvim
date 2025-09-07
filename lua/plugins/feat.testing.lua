---@diagnostic disable: missing-fields
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "mfandrade/neotest-jest", -- bugs fixed
  },
  config = function()
    require("neotest").setup({
      settings = { watch = true },
      adapters = {
        require("neotest-jest")({
          jestCommand = "npx jest --runInBand --json",
          jestConfigFile = "jest.config.js",
          env = { CI = true, NODE_ENV = "test" },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}

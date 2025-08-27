return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({
      settings = { watch = true },
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest"),
      },
    })
  end,
}

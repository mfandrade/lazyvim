return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      chat = {
        auto_scroll = false,
      },
    },
    strategies = {
      chat = { adapter = "gemini" },
      inline = { adapter = "gemini" },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

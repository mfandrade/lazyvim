return {
  {

    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CC: Toggle chat panel" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "CC: New chat" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: Actions panel" },
    },
    opts = {
      display = {
        chat = { auto_scroll = false },
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
      },
    },
  },
}

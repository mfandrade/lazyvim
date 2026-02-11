return {
  {
    "kiddos/gemini.nvim",
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CC: Toggle chat panel" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "CC: New chat" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: Actions panel" },
      "ravitemer/mcphub.nvim",
    },
    opts = {
      display = {
        chat = { auto_scroll = false },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.0.flash",
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CC: Toggle chat panel" },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CC: Add selection to context" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: Actions panel" },
    },
    config = function(opts)
      require("codecompanion").setup(opts)
      vim.cmd("cab cc CodeCompanion")
    end,
  },
}

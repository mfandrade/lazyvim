return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CC: Toggle chat panel" },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "CC: New chat" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: Actions panel" },
  },
  opts = {
    display = {
      chat = {
        auto_scroll = false,
      },
    },
    strategies = {
      chat = {
        adapter = "gemini",
        variables = {
          ["buffer"] = {
            callback = function()
              return require("codecompanion.helpers.variables.buffer").callback({
                filter = function(bufnr)
                  return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) ~= ""
                end,
              })
            end,
          },
        },
      },
      inline = { adapter = "gemini" },
    },
  },
}

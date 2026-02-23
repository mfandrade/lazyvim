local model = "gemini-flash-latest"

return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      build = "pnpm install -g mcp-hub@latest",
      config = function()
        require("mcphub").setup()
      end,
    },
  },
  init = function()
    vim.cmd("cabbr cc CodeCompanion")
    vim.cmd("cabbr ccc CodeCompanionChat")
  end,
  keys = {
    { "<localleader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CC: toggle" },
    { "<localleader>p", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: actions panel" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CC: add selection to chat" },
    { "<localleader>i", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CC: inline prompt" },
    { "<localleader>e", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "CC: explain selected code" },
  },
  config = function()
    require("codecompanion").setup({
      display = { chat = { auto_scroll = true } },
      strategies = {
        chat = {
          adapter = {
            name = "gemini",
            model = model,
          },
        },
        inline = {
          adapter = {
            name = "gemini",
            model = model,
          },
        },
        agent = {
          adapter = {
            name = "gemini",
            model = model,
          },
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_tools = true,
            show_server_tools_in_chat = true,
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
    })
  end,
}

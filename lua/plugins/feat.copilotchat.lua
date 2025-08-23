return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      -- { "zbirenbaum/copilot.lua" },
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      auto_insert_mode = true,
      model = "claude-3.5-sonnet", -- AI model to use
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = "float", -- 'vertical', 'horizontal', 'float'
        height = 30,
        width = 0.6,
      },
      headers = {
        user = "   Me ",
        assistant = "   Copilot ",
        tool = " 🛠 Tool ",
      },
      -- separator = "━━",
      -- show_folds = true,
    },
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle Copilot Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt actions",
        mode = { "n", "v" },
      },
      { "<leader>ae", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
      { "<leader>ar", ":CopilotChatReview<CR>", mode = "v", desc = "Review code" },
      { "<leader>af", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code issues" },
      { "<leader>ao", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
      { "<leader>ad", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
      { "<leader>at", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
      { "<leader>am", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate commit message" },
      { "<leader>as", ":CopilotChatCommit<CR>", mode = "v", desc = "Generate commit message for selection" },
    },
  },
}

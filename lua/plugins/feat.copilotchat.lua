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
      model = "gpt-4.1", -- AI model to use
      temperature = 0.1, -- lower = focused, higher = creative
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.4,
        -- height = 30,
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
      { "<leader>aa", ":CopilotChat<CR>", mode = { "n", "v" }, desc = "Copilot Chat" },
      { "<leader>ax", ":CopilotChatReset<CR>", mode = { "n", "v" }, desc = "Clear chat history" },
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
        mode = { "n", "v" },
        desc = "Quick chat",
      },
      { "<leader>ap", ":CopilotChatPrompt<CR>", mode = { "n", "v" }, desc = "Select prompt" },
      { "<leader>ae", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
      { "<leader>ar", ":CopilotChatReview<CR>", mode = "v", desc = "Review code" },
      { "<leader>af", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code issues" },
      { "<leader>ao", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
      { "<leader>ad", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
      { "<leader>at", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
      { "<leader>am", ":CopilotChatCommit<CR>", mode = { "n", "v" }, desc = "Generate commit message" },
    },
  },
}

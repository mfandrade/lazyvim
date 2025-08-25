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
        user = "   Me ─",
        assistant = "   Copilot ─",
        tool = " 🛠 Tool ─",
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<C-s>", "<CR>", ft = "copilot-chat", desc = "Submit prompt", remap = true },
      { "<leader>aa", "<cmd>CopilotChat<CR>", mode = { "n", "v" }, desc = "CopilotChat" },
      { "<leader>ax", "<cmd>CopilotChatReset<CR>", mode = { "n", "v" }, desc = "Clear current chat" },
      { "<leader>ap", "<cmd>CopilotChatPrompt<CR>", mode = { "n", "v" }, desc = "Predefined prompts" },
      { "<leader>ae", "<cmd>CopilotChatExplain<CR>", mode = "v", desc = "Explain this code" },
      { "<leader>ar", "<cmd>CopilotChatReview<CR>", mode = "v", desc = "Review this code" },
      { "<leader>af", "<cmd>CopilotChatFix<CR>", mode = "v", desc = "Fix this code issues" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<CR>", mode = "v", desc = "Optimize this code" },
      { "<leader>ad", "<cmd>CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
      { "<leader>at", "<cmd>CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
      { "<leader>am", "<cmd>CopilotChatCommit<CR>", mode = { "n", "v" }, desc = "Generate commit message" },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick question: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick question",
        mode = { "n", "v" },
      },
    },
  },
}

local adapter = "mistral_vibe" -- Options: mistral_vibe, gemini, anthropic, deepseek

return {
  "olimorris/codecompanion.nvim",
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
    { "<localleader>i", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CC: inline prompt" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CC: add selection to chat" },
    { "ge", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "CC: explain selection" },
  },
  config = function()
    require("codecompanion").setup({
      display = { chat = { auto_scroll = false } },
      strategies = {
        chat = { adapter = adapter },
        inline = { adapter = adapter },
        agent = { adapter = adapter },
      },
    })
  end,
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        show_result_in_chat = true, -- Show tool results directly in chat buffer
        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
        -- MCP Resources
        make_vars = true, -- Convert MCP resources to #variables for prompts
        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
  },
}

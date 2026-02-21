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
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CC: toggle" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CC: actions panel" },
    { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CC: add selection to chat" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CC: inline prompt" },
    { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "CC: explain selected code" },
  },
  opts = {
    display = { chat = { auto_scroll = true } },
    adapters = {
      gemini = function()
        local conf = nil

        if os.getenv("GOOGLE_CLOUD_PROJECT") then
          conf = {
            schema = {
              project_id = { default = os.getenv("GOOGLE_CLOUD_PROJECT") },
              location = {
                default = os.getenv("GOOGLE_CLOUD_REGION") or os.getenv("GOOGLE_CLOUD_LOCATION") or "us-central1",
              },
              model = { default = "gemini-2.5-flash" },
            },
          }
        elseif os.getenv("GEMINI_API_KEY") then
          conf = {
            env = {
              api_key = "GEMINI_API_KEY",
            },
          }
        else
          vim.notify(
            "CodeCompanion: Set GEMINI_API_KEY or set GOOGLE_CLOUD_PROJECT and run `gcloud auth application-default login`",
            vim.log.levels.WARN
          )
          return nil
        end

        return require("codecompanion.adapters").extend("gemini", conf)
      end,
    },
    strategies = {
      chat = {
        adapter = "gemini",
        keymaps = { -- https://github.com/olimorris/codecompanion.nvim/discussions/1288
          options = {
            modes = { n = "?" },
            callback = function()
              require("which-key").show({ global = false })
            end,
            description = "CodeCompanion Keymaps",
            hide = true,
          },
        },
      },
      inline = { adapter = "gemini" },
      agent = { adapter = "gemini" },
    },
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
  },
}

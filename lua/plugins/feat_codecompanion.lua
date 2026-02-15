vim.cmd("cab cc CodeCompanion")
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
      "ravitemer/codecompanion-history.nvim",
      "ravitemer/mcphub.nvim",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CC: Toggle chat panel" },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CC: Add selection" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "CC: New chat" },
      { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", desc = "CC: History" },
      { "<leader>as", "<cmd>CodeCompanionSummaries<cr>", desc = "CC: Summaries" },
    },
    opts = {
      display = {
        chat = { auto_scroll = false },
      },
      strategies = {
        chat = {
          adapter = "gemini",
          keymaps = {
            send = {
              modes = {
                n = "<CR>", -- Mantém o Enter no modo Normal
                i = "<C-M-c>", -- Altera para Ctrl+Alt+c no modo Insert
              },
              index = 1,
              callback = "keymaps.send",
              description = "Send",
            },
          },
        },
        inline = { adapter = "gemini" },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = { default = "gemini-2.0-flash" },
            },
          })
        end,
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "default",
            auto_generate_title = true,
            title_generation_opts = {
              max_refreshes = 3,
            },
            continue_last_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            summary = {
              create_summary_keymap = "gcs",
              browse_summaries_keymap = "gbs",
              generation_opts = {
                context_size = 90000,
                include_references = true,
                include_tool_outputs = true,
              },
            },
            memory = {
              auto_create_memories_on_summary_generation = true,
              vectorcode_exe = "vectorcode",
              tool_opts = { default_num = 10 },
              notify = true,
              index_on_startup = false,
            },
          },
        },
      },
    },
  },
}

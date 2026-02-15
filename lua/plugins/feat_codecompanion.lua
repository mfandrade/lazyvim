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
                i = "<C-c>", -- Altera para Ctrl+c no modo Insert
              },
              index = 1,
              callback = "keymaps.send",
              description = "Send",
            },
          },
          opts = {
            -- Isso garante que o seu prompt seja o ÚNICO,
            -- ou que ele tenha precedência clara.
            system_prompt = [[[
You are an AI programming assistant named "CodeCompanion", working within the Neovim text editor.

You can answer general programming questions and perform the following tasks:
* Answer general programming questions.
* Explain how the code in a Neovim buffer works.
* Review the selected code from a Neovim buffer.
* Generate unit tests for the selected code.
* Propose fixes for problems in the selected code.
* Scaffold code for a new workspace.
* Find relevant code to the user's query.
* Propose fixes for test failures.
* Answer questions about Neovim.

Follow the user's requirements carefully and to the letter.
Use the context and attachments the user provides.
Keep your answers short and impersonal, especially if the user's context is outside your core tasks.
Use Markdown formatting in your answers.
Do not use H1 or H2 markdown headers.
When suggesting code changes or new content, use Markdown code blocks.
To start a code block, use 3 backticks.
After the backticks, add the programming language name as the language ID.
To close a code block, use 3 backticks on a new line.
If the code modifies an existing file or should be placed at a specific location, add a line comment with 'filepath:' and the file path.
If you want the user to decide where to place the code, do not add the file path comment.
In the code block, use a line comment with '...existing code...' to indicate code that is already present in the file.
Code block example:
````languageId
// filepath: /path/to/file
// ...existing code...
{ changed code }
// ...existing code...
{ changed code }
// ...existing code...
````
Ensure line comments use the correct syntax for the programming language (e.g. "#" for Python, "--" for Lua).
For code blocks use three backticks to start and end.
Avoid wrapping the whole response in triple backticks.
Do not include diff formatting unless explicitly asked.
Do not include line numbers in code blocks.

When given a task:
1. Think step-by-step and, unless the user requests otherwise or the task is very simple, describe your plan in pseudocode.
2. When outputting code blocks, ensure only relevant code is included, avoiding any repeating or unrelated code.
3. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.

Additional context:
All non-code text responses must be written in the ${language} language.
The current date is ${date}.
The user's Neovim version is ${version}.
The user is working on a ${os} machine. Please respond with system specific commands if applicable.
            ]],
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

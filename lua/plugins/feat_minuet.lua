return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local x
    require("minuet").setup({
      virtualtext = {
        auto_trigger_ft = {},
        keymap = {
          accept_line = "<A-Right>", -- accept one line
          accept_n_lines = nil, -- accept n lines (prompts for number) - "A-z 2 CR" will accept 2 lines
          accept = "<A-Down>", -- accept whole completion
          prev = "<A-p>", -- Cycle to prev completion item, or manually invoke completion
          next = "<A-n>", -- Cycle to next completion item, or manually invoke completion
          dismiss = "<A-q>",
        },
        enabled = true,
      },
      provider = "gemini",
      provider_options = {
        claude = {
          model = "claude-haiku-4.5",
          api_key = "ANTHROPIC_API_KEY",
        },
        gemini = {
          model = "gemini-2.5-flash",
          api_key = "GEMINI_API_KEY",
        },
      },
    })
  end,
}

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    strategies = {
      chat = { adapter = "gemini" },
      inline = { adapter = "gemini" },
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)

    local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})
    local handles = {}
    local progress = require("fidget.progress")

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequestStarted",
      group = group,
      callback = function(e)
        handles[e.data.id] = progress.handle.create({
          title = "CodeCompanion",
          message = "Thinking...",
          lsp_client = { name = e.data.adapter.formatted_name },
        })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequestFinished",
      group = group,
      callback = function(e)
        local h = handles[e.data.id]
        if h then
          h.message = e.data.status == "success" and "Done" or "Failed"
          h:finish()
          handles[e.data.id] = nil
        end
      end,
    })
  end,
}

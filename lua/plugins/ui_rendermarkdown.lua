return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
  ft = { "markdown", "codecompanion" },
  opts = {
    heading = {
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      -- icons = { "󱅊 ", "󱅋 ", "󱅌 ", "󱅍 ", "󱅎 ", "󱅏 " },
      -- icons = { "󰇊 ", "󰇋 ", "󰇌 ", "󰇍 ", "󰇎 ", "󰇏 " },
      icons = { "󰫈 ", "󰫇 ", "󰫆 ", "󰫅 ", "󰫄 ", "󰫃 " },
      -- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      -- icons = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
      position = "inline",
      -- left_pad = 1,
      -- file_types = { "markdown", "codecompanion" },
    },
  },
}

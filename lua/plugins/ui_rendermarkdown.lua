return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  opts = {
    heading = {
      -- signs = { " ", "", "", "", "", "" },
      -- signs = { " ", " ", " ", "", "", "" },
      signs = { "·", "·", "·", "·", "·", "·" },
      -- signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      sign = true,
      icons = { "󰫈 ", "󰫇 ", "󰫆 ", "󰫅 ", "󰫄 ", "󰫃 " },
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      -- icons = { "󱅊 ", "󱅋 ", "󱅌 ", "󱅍 ", "󱅎 ", "󱅏 " },
      -- icons = { "󰇊 ", "󰇋 ", "󰇌 ", "󰇍 ", "󰇎 ", "󰇏 " },
      -- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      -- icons = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
      position = "inline",
    },
    paragraph = {
      left_margin = 2,
    },
    bullet = {
      left_pad = 2,
    },
    checkbox = {
      left_pad = 2,
    },
    pipe_table = {
      preset = "round",
    },
    code = {
      position = "right",
      width = "block",
      min_width = 70,
      left_pad = 3,
      right_pad = 1,
      language_right = "█",
      border = "thick",
      inline_pad = 1,
    },
  },
}

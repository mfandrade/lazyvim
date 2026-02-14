return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  opts = {
    heading = {
      sign = true,
      signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      -- signs = { " ", " ", " ", "", "", "" },
      -- signs = { "·", "·", "·", "·", "·", "·" },
      position = "inline",
      icons = { "󰫈 ", "󰫇 ", "󰫆 ", "󰫅 ", "󰫄 ", "󰫃 " },
      -- icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- icons = { "󱅊 ", "󱅋 ", "󱅌 ", "󱅍 ", "󱅎 ", "󱅏 " },
      -- icons = { "󰇊 ", "󰇋 ", "󰇌 ", "󰇍 ", "󰇎 ", "󰇏 " },
      -- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      -- icons = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
    },
    paragraph = {
      left_margin = 0,
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
    latex = { enabled = false },
  },
}

local icons = {
  h123 = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
  bars = { "▇ ", "▆ ", "▅ ", "▄ ", "▃ ", "▂ " },
  marks = { " ", " ", " ", " ", " ", " " },
  hashs = { " ", " ", " ", " ", " ", " " },
  dots = { "· ", "· ", "· ", "· ", "· ", "· " },
  hexa = { "󰫈 ", "󰫇 ", "󰫆 ", "󰫅 ", "󰫄 ", "󰫃 " },
  dice = { "󱅊 ", "󱅋 ", "󱅌 ", "󱅍 ", "󱅎 ", "󱅏 " },
  Dice = { "󰇊 ", "󰇋 ", "󰇌 ", "󰇍 ", "󰇎 ", "󰇏 " },
  circle = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  Circle = { "󰲠 ", "󰲢 ", "󰲤 ", "󰲦 ", "󰲨 ", "󰲪 " },
  square = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
  Square = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
  digital = { "🯱 ", "🯲 ", "🯳 ", "🯴 ", "🯵 ", "🯶 " },
}

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion", "Avante" },
  opts = {
    file_types = { "markdown", "codecompanion", "Avante" },
    heading = {
      sign = false,
      signs = icons.hashs,
      position = "inline",
      icons = icons.hexa,
    },
    paragraph = {
      left_margin = 0,
    },
    bullet = {
      left_pad = 0,
    },
    checkbox = {
      left_pad = 0,
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

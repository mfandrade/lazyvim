return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = { enabled = true },
    statuscolumn = { enabled = true },
    dashboard = { enabled = true },
    lazygit = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    scope = { enabled = true, animate = { enabled = false } },
    picker = {
      enabled = true,
      filter = { exclude = { ".git", "node_modules" } },
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          win = { list = { wo = { number = true, relativenumber = true } } },
        },
      },
    },
  },
}

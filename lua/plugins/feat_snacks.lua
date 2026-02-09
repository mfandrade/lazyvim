return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    scope = { enabled = true, animate = { enabled = false } },
    picker = {
      enabled = true,
      filter = { exclude = { ".git", "node_modules" } },
      sources = { explorer = { layout = { layout = { position = "right" } } } },
    },
  },
}

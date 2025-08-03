return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
    },
    formatters = {
      shfmt = {
        command = "shfmt",
        args = { "-i", "4", "-ci" },
        -- prepend_args = { "-i", "4", "-ci" },
      },
    },
  },
}

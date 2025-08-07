return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
    },
    formatters = {
      shfmt = function(bufnr)
        return {
          command = "shfmt",
          args = { "-i", tostring(vim.bo[bufnr].shiftwidth), "-ci" },
        }
      end,
    },
  },
}

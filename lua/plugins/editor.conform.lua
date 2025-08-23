return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = false,
    formatters = {
      shfmt = function(bufnr)
        return {
          command = "shfmt",
          args = { "-i", tostring(vim.bo[bufnr].shiftwidth), "-ci" },
        }
      end,
      prettier = {
        command = "prettier",
        args = {
          "--stdin-filepath",
          "$FILENAME",
        },
        stdin = true,
        cwd = require("conform.util").root_file({ ".prettierrc", "package.json", ".git" }),
      },
    },
  },
}

return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
      lua = { "stylua" },
      fish = { "fish_indent" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
    },
    format_on_save = false,
    formatters = {
      injected = { options = { ignore_errors = true } },
      shfmt = function(bufnr)
        return {
          command = "shfmt",
          args = { "-i", tostring(vim.bo[bufnr].shiftwidth or 2), "-ci" },
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

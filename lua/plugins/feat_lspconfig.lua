return {
  "neovim/nvim-lspconfig",
  keys = {
    { "K", false },
    { "<leader>k", vim.lsp.buf.hover, desc = "Hover Documentation" },
  },
  opts = {
    folds = { enabled = false },
  },
}

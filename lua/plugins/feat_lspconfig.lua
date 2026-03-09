return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "K", false },
          { "<leader>k", vim.lsp.buf.hover, desc = "Hover documentation" },
        },
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        -- stylua: ignore
        keys = {
          { "K", false },
          { "<leader>k", function() vim.lsp.buf.hover() end, desc = "Hover documentation", },
        },
      },
    },
  },
}

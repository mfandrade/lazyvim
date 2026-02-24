return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.keys = {
      { "K", false },
      { "gk", vim.lsp.buf.hover, desc = "Hover Documentation" },
    }
    opts.diagnostics = {
      float = { border = "rounded" },
    }
  end,
}

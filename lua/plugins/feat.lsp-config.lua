return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      underline = true,
      -- signs = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
        },
      },
    },
    inlay_hints = {
      enabled = false,
    },
  },
}

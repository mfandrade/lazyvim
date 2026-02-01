return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
  },
  opts = {
    servers = {
      lua_ls = {
        settings = { Lua = { diagnostics = { globals = { "vim", "Snacks" } } } },
      },
      ts_ls = {
        on_attach = function(client, bufnr)
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end,
      },
    },
  },
  config = function(_, opts)
    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(opts.servers) })
    for server, config in pairs(opts.servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}

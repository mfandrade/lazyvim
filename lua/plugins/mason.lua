return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
  },
  opts = {
    servers = { -- NOTE: you must set your Mason language servers here!
      lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
      stylua = {},
      ts_ls = {
        on_attach = function(client, _bufnr)
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
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

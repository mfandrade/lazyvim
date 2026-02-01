return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = { -- NOTE: you must set your Mason language servers here!
      lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
      stylua = {},
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

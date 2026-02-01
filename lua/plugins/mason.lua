local lua = { "lua_ls", "stylua" }
local js = { "vtsls", "prettier" }
local py = {}

local servers = vim.iter({ lua, js, py }):flatten():totable()
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    servers = {
      lua_ls = {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } }
      },
      stylua = {}
    },
  },
  config = function(_, opts)
    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = servers })
    for server, config in pairs(opts.servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end
}

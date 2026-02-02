return {
  "mason-org/mason.nvim",
  dependencies = { "artemave/workspace-diagnostics.nvim" },
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            hint = { arrayIndex = "disable" },
          },
        },
      },
      vtsls = {
        on_attach = function(client, bufnr)
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end,
      },
    },
  },
}

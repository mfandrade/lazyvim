---@diagnostic disable: undefined-global
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "igorlfs/nvim-dap-view", opts = { winbar = { controls = { enabled = true } } } },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "jay-babu/mason-nvim-dap.nvim",
  },
  -- stylua: ignore
  keys = {
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>dD", function() require("dap").disconnect() end, desc = "Disconnect" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
    { "<c-down>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<c-right>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<c-left>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<c-up>", function() require("dap").restart_frame() end, desc = "Restart" },
    { "<leader>di", function() require('dap-view').add_watch() end, desc = "Inspect in Watch Panel" },
    { "<leader>dv", function() require('dap-view').toggle() end, desc = "Toggle View Panel" },
    { "<leader>dV", function() require('nvim-dap-virtual-text').toggle() end, desc = "Toggle Virtual Text" },
  },
  config = function()
    local dap = require("dap")

    -- Utilitário global para argumentos (útil em vários ftplugins)
    _G.dap_get_args = function()
      local args_str = vim.fn.input("Arguments: ")
      return vim.split(args_str, " +")
    end

    -- 1. Mason DAP
    require("mason-nvim-dap").setup({
      ensure_installed = { "python", "delve", "js-debug-adapter" },
      automatic_installation = true,
    })

    -- 2. Ícones e Sinais
    local icons = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = { " ", "DiagnosticInfo" },
      BreakpointCondition = { " ", "DiagnosticInfo" },
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = { ".>", "DiagnosticInfo" },
    }
    for name, sign in pairs(icons) do
      vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
    end

    -- 3. Adaptador Node (Global)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    local js_config = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug this file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
      },
    }
    dap.configurations.javascript = js_config
    dap.configurations.typescript = js_config
    dap.configurations.javascriptreact = js_config
    dap.configurations.typescriptreact = js_config

    -- Esta é a forma correta de mapear os tipos do VS Code para as linguagens do Neovim
    local vscode = require("dap.ext.vscode")

    vscode.type_to_filetypes = {
      ["pwa-node"] = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      ["node"] = { "javascript", "typescript" },
      ["python"] = { "python" },
    }
  end,
}

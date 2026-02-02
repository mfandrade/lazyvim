return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      opts = {
        winbar = {
          controls = { enabled = true },
        },
      },
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "python", "delve", "js-debug-adapter" },
        automatic_installation = true,
      },
    },
  },
  -- Em vez de sobrescrever config, usamos opts para estender a configuração do LazyVim
  opts = function()
    local dap = require("dap")

    -- 1. Utilitários
    _G.dap_get_args = function()
      local args_str = vim.fn.input("Arguments: ")
      return vim.split(args_str, " +")
    end

    -- 2. Configuração de Ícones (movido do config para cá)
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

    -- 3. Adaptadores
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

    -- 4. Linguagens
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

    -- Retornamos uma tabela vazia ou com configurações globais do DAP se necessário
    return {}
  end,
  -- stylua: ignore
  keys = {
    { "<leader>dd", function() require("dap").continue() end, desc = "Run/Continue Debug" },
    { "<leader>dD", function() require("dap").disconnect() end, desc = "Disconnect" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
    { "<c-down>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<c-right>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<c-left>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<c-up>", function() require("dap").restart_frame() end, desc = "Restart" },
    {
      "<leader>di",
      function()
        require("dap.ui.widgets").hover(nil, { border = "rounded" })
        vim.schedule(function()
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_get_current_buf()
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
            vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
          end
        end)
      end,
      desc = "Inspect Value",
    },
    { "<leader>dw", function() local dv = require('dap-view'); dv.add_expr(); dv.open(); dv.jump_to_view("watches") end, desc = "Add to Watch Panel"},
    { "<leader>dv", function() require('dap-view').toggle() end, desc = "Toggle View Panel" },
    { "<leader>dV", function() require('nvim-dap-virtual-text').toggle() end, desc = "Toggle Virtual Text" },
  },
}

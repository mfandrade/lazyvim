return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    {
      "igorlfs/nvim-dap-view",
      opts = {
        winbar = {
          controls = { enabled = true },
        },
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "python", "delve", "js-debug-adapter" },
        automatic_installation = true,
      },
    },
  },
  config = function()
    local dap = require("dap")

    -- 1. icons and signs
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

    -- 2. adapters
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

    -- 3. languages conf
    local js_config = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "--experimental-vm-modules",
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        sourceMaps = true,
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Run package.json Script",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "${command:PickProcess}" }, -- TODO: filter process
        args = { "--inspect-brk" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
    }

    for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[lang] = js_config
    end
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
    { "<leader>di",
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
      desc = "Inspect Value", },
    { "<leader>dw", function() local dv = require('dap-view'); dv.add_expr(); dv.open(); dv.jump_to_view("watches") end, desc = "Add to Watch Panel"},
    { "<leader>dv", function() require('dap-view').toggle() end, desc = "Toggle View Panel" },
    { "<leader>dV", function() require('nvim-dap-virtual-text').toggle() end, desc = "Toggle Virtual Text" },
  },
}

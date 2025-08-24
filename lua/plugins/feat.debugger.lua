return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
  },
  ft = { "go" },
  config = function()
    -- set icons for breakpoints
    local config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    for name, sign in pairs(config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define("Dap" .. name, {
        text = type(sign[1]) == "string" and sign[1] or vim.inspect(sign[1]),
        texthl = sign[2] or "DiagnosticInfo",
        linehl = sign[3],
        numhl = sign[3],
      })
    end

    require("plugins.dap.go")
  end,
  keys = {
    -- { "<F9>", "<cmd>lua require'dap'.toggle_breakpoing()<CR>", desc = "Toggle Breakpoing" },
    { "<F10>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
    { "<F11>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
    { "<S-F11>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
    { "<S-F5>", "<cmd>lua require'dap'.terminate()<CR>", desc = "Terminate" },
    { "<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "Run/Continue" },
    -- { "<S-Down>", "<cmd>lua require'dap'.toggle_breakpoing()<CR>", desc = "Toggle Breakpoing" },
    { "<Down>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
    { "<Right>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
    { "<Left>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
    { "<S-Up>", "<cmd>lua require'dap'.terminate()<CR>", desc = "Terminate" },
    { "<Up>", "<cmd>lua require'dap'.continue()<CR>", desc = "Run/Continue" },
  },
}

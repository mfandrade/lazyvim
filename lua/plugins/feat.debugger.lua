-- global function to get absolute path for mason adapters
_G.find_adapter = function(adapter, filename)
  pcall(require, "mason")

  local mason_dir = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  local adapter_dir = mason_dir .. "/packages/" .. adapter
  if vim.fn.isdirectory(adapter_dir) == 0 then
    error("Adapter directory not found: " .. adapter_dir)
  end

  local matches = vim.fn.globpath(adapter_dir, "**/" .. filename, false, true)
  if #matches == 0 then
    error("File '" .. filename .. "' not found in adapter: " .. adapter)
  end

  return matches[1]
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "leoluz/nvim-dap-go" },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
  },
  ft = { "go", "javascript" },
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

    require("plugins.dap.golang")
    require("plugins.dap.javascript")
  end,
  keys = {
    -- { "<F9>", "<cmd>lua require'dap'.toggle_breakpoing()<CR>", desc = "Toggle Breakpoing" },
    { "<F10>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
    { "<F11>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
    { "<S-F11>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
    { "<S-F5>", "<cmd>lua require'dap'.terminate()<CR>", desc = "Terminate" },
    { "<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "Run/Continue" },
    -- { "<Up>", "<cmd>lua require'dap'.toggle_breakpoing()<CR>", desc = "Toggle Breakpoing" },
    { "<Down>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
    { "<Right>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
    { "<Left>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
    { "<S-Up>", "<cmd>lua require'dap'.terminate()<CR>", desc = "Terminate" },
    { "<S-Down>", "<cmd>lua require'dap'.continue()<CR>", desc = "Run/Continue" },
  },
}

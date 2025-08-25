local js_adapter = _G.find_adapter("js-debug-adapter", "dapDebugServer.js")
local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_adapter, "${port}" },
  },
}

dap.configurations.javascript = {
  {
    name = "Debug a Node server [--inspect]",
    type = "pwa-node",
    request = "attach",
    port = 9229, -- default adapter port, not server port
    host = "localhost",
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    name = "Debug Jest tests",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--inspect",
      "${workspaceFolder}/node_modules/jest/bin/jest.js",
      "--runInBand",
    },
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    name = "Debug a single file",
    type = "pwa-node",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = "${file}",
  },
}

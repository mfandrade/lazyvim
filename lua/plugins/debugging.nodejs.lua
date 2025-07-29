-- Based on
-- - https://www.youtube.com/watch?v=Ul_WPhS2bis
-- - https://github.com/nikolovlazar/dotfiles/blob/92c91ed035348c74e387ccd85ca19a376ea2f35e/.config/nvim/lua/plugins/dap.lua
local js_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string the name of the Mason package
---@param path? string the name of the file to be searched
local function get_pkg_path(pkg, path)
  pcall(require, "mason")
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    local config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        ---@diagnostic disable-next-line: assign-type-mismatch
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local dap_vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    ---@diagnostic disable-next-line: duplicate-set-field
    dap_vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str, {}))
    end

    dap_vscode.type_to_filetypes["node"] = js_languages

    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["pwa-chrome"] then
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, conf)
        if conf.type == "node" then
          conf.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, conf)
        else
          cb(nativeAdapter)
        end
      end
    end

    if not dap.adapters["chrome"] then
      dap.adapters["chrome"] = function(cb, conf)
        if conf.type == "chrome" then
          conf.type = "pwa-chrome"
        end
        local nativeAdapter = dap.adapters["pwa-chrome"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, conf)
        else
          cb(nativeAdapter)
        end
      end
    end

    for _, language in ipairs(js_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          name = "Debug a single file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          args = { "${file}" },
          sourceMaps = true,
          sourceMapPathOverrides = {
            ["./*"] = "${workspaceFolder}/src/*",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Debug a running server",
          port = 9229, -- Conecta diretamente à porta
          host = "localhost",
          cwd = "${workspaceFolder}",
          protocol = "inspector",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        -- {
        --   name = "Debug a running process",
        --   type = "pwa-node",
        --   request = "attach",
        --   processId = function()
        --     local function filter_node_processes(process)
        --       local name = process.name:lower()
        --       local command = process.command:lower()
        --
        --       -- filter 'node' processes, except 'vsDebugServer.js' and shell initiated ones
        --       -- e os processos de shell que iniciam 'node'.
        --       return (name == "node" or command:find("node"))
        --         and not command:find("vsdebugserver.js")
        --         and not command:find("sh %-c node")
        --         and not command:find("bash %-c node")
        --         and not command:find("zsh %-c node")
        --       -- Adicione outras exclusões se houver processos node indesejados (ex: nodemon)
        --     end
        --
        --     return require("dap.utils").pick_process(filter_node_processes)
        --   end,
        --   cwd = "${workspaceFolder}",
        --   sourceMaps = true,
        -- },
        {
          name = "Debug jest tests",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "node",
          runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          -- args = {'${file}', '--coverage', 'false'},
          -- sourceMaps = true,
          -- skipFiles = {'node_internals/**', 'node_modules/**'},
        },
        {
          name = "Debug vitest tests",
          type = "pwa-node",
          request = "launch",
          cwd = vim.fn.getcwd(),
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          args = { "run", "${file}" },
          autoAttachChildProcesses = true,
          smartStep = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Debug web applications (client side)
        {
          name = "Debug in Chrome (client side)",
          type = "pwa-chrome",
          request = "launch",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },

          -- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
          -- To test how it behaves
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMapPathOverrides = {
            ["./*"] = "${workspaceFolder}/src/*",
          },
        },
        {
          name = "--------------- ↓ configs from launch.json (if present) ↓ ---------------",
          type = "",
          request = "launch",
        },
      }
    end
  end,
  keys = {
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
  },
  dependencies = {
    { "nvim-neotest/nvim-nio" },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
  },
}

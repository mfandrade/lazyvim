local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
local function get_pkg_path(pkg, path)
  pcall(require, "mason")
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

return {
  { "nvim-neotest/nvim-nio" },
  {
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

      dap_vscode.type_to_filetypes["node"] = js_based_languages

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

      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          {
            name = "⚙️ Debug a running server [--inspect-brk …]",
            type = "pwa-node",
            request = "attach",
            port = 9229, -- Conecta diretamente à porta
            host = "localhost",
            cwd = "${workspaceFolder}",
            protocol = "inspector",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            name = "🌐 Debug in Chrome (client side)",
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
            name = "🚥 Debug jest tests",
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
            name = "▶️ Debug a file",
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
          -- {
          --    name = "Debug vitest tests",
          --    type = "pwa-node",
          --    request = "launch",
          --    cwd = vim.fn.getcwd(),
          --    program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          --    args = { "run", "${file}" },
          --    autoAttachChildProcesses = true,
          --    smartStep = true,
          --    skipFiles = { "<node_internals>/**", "node_modules/**" },
          -- },
          {
            name = "--------------- ↓ configs from launch.json (if present) ↓ --------------- ",
            type = "",
            request = "launch",
          },
        }
      end
    end,
    keys = {
      {
        "<F5>", -- "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F6>", -- "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F7>", -- "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F8>",
        function()
          require("dap").continue({ true })
        end,
        desc = "Run/Continue",
      },
    },
    dependencies = {
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
}

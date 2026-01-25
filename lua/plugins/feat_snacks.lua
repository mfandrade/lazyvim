---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
    scope = {
      enabled = true,
      animate = { enabled = false },
    },
    picker = {
      exclude = {
        ".git",
        "node_modules",
      },
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>uC",
      function()
        local runtime = vim.env.VIMRUNTIME:gsub("\\", "/")
        Snacks.picker.colorschemes({
          layout = { preset = "vscode" },
          transform = function(item)
            local path = (item.file or ""):gsub("\\", "/")
            if path:find(runtime, 1, true) then
              return false
            end
          end,
        })
      end,
      desc = "Colorschemes",
    },
  },
}

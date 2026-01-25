---@diagnostic disable: undefined-global
return {
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
    opts = {},
  },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = { startVisible = false },
    config = function(_, opts)
      local pre = require("precognition")
      pre.setup(opts)

      -- Rastreia o estado internamente para o toggle não se perder
      local is_visible = opts.startVisible

      Snacks.toggle({
        name = "Precognition",
        get = function()
          return is_visible
        end,
        set = function(state)
          is_visible = state
          if state then
            pre.show()
          else
            pre.hide()
          end
        end,
      }):map("<leader>up")
    end,
  },
}

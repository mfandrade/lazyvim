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
    opts = { startVisible = false },
    -- stylua: ignore start
    config = function(_, opts)
      local pre = require("precognition")
      pre.setup(opts)
      local is_enabled = opts.startVisible
      Snacks.toggle({ name = "Precognition",
        get = function() return is_enabled end,
        set = function(state)
          is_enabled = state
          if state then pre.show()
          else pre.hide() end
        end,
      }):map("<leader>uP")
    end,
    -- stylua: ignore end
  },
}

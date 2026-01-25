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
  -- {
  --   "tris203/precognition.nvim",
  --   event = "VeryLazy",
  --   opts = { startVisible = false },
  --   config = function(_, opts)
  --     local pre = require("precognition")
  --     pre.setup(opts)
  --     -- stylua: ignore start
  --     Snacks.toggle({ name = "Precognition",
  --       get = function() return opts.startVisible end,
  --       set = function(state)
  --         if state then pre.show()
  --         else pre.hide() end
  --       end,
  --     -- stylua: ignore end
  --     }):map("<leader>up")
  --   end,
  -- },
}

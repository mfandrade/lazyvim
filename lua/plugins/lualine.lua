return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_z = {} -- removes clock

    return opts
  end,
}

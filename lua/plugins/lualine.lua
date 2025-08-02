return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local catppuccin = require("catppuccin.palettes").get_palette()
    opts.sections = opts.sections or {}
    opts.sections.lualine_z = {}
    opts.options = opts.options or {}

    if type(opts.options.theme) == "string" then
      local theme_name = opts.options.theme
      opts.options.theme = require("lualine.themes." .. theme_name) or {}
    end

    opts.options.theme = opts.options.theme or {}
    opts.options.theme.insert = {
      a = { fg = catppuccin.red, bg = catppuccin.base },
    }
    return opts
  end,
}

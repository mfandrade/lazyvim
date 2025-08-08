return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_background = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.Folded = {
          fg = c.blue0, -- Foreground color (text color)
          bg = c.bg_dark, -- Background color
          italic = true,
        }
        hl.FoldColumn = {
          fg = c.green,
          bg = c.bg_dark,
        }
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}

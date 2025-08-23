return {
  {
    "fxn/vim-monochrome",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.monochrome_italic_comments = 1
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
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
        hl.LineNrAbove = { fg = c.comment }
        hl.LineNrBelow = { fg = c.comment }
        hl.CursorLineNr = { fg = c.orange, bold = true }
      end,
    },
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      groups = {
        "Normal",
        "NormalNC",
        "NvimTreeNormal",
      },
      extra_groups = {
        "SignColumn",
      },
      exclude_groups = {
        "NormalFloat",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "MasonNormal",
        "LspInfoBorder",
        "WhichKey",
        "WhichKeyFloat",
        "WhichKeyBorder",
        "WhichKeySeparator",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight", --TODO: set colorscheme here
    },
  },
}

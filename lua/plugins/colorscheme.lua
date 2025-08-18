return {
  {
    "fxn/vim-monochrome",
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
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      groups = {
        "Normal",
        "NormalNC",
        "NvimTreeNormal",
      },
      extra_groups = {},
      exclude_groups = {
        "NormalFloat",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "MasonNormal",
        "LspInfoBorder",
      },
    },
    config = function(_, opts)
      require("transparent").setup(opts)

      -- fix which-key border with gruvbox
      vim.cmd([[
      augroup GruvboxTransparentFix
        autocmd!
        autocmd ColorScheme gruvbox highlight FloatBorder guibg=NONE guifg=#928374
        autocmd ColorScheme gruvbox highlight WhichKeyBorder guibg=NONE guifg=#928374
      augroup END
    ]])
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monochrome", --TODO: set the colorscheme
    },
  },
}

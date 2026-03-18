return {
  {
    "amedoeyes/eyes.nvim",
    lazy = true,
  },
  {
    "funnyVariable/blank.nvim",
    lazy = true,
  },
  {
    "Lokaltog/vim-monotone",
    lazy = true,
  },
  {
    "KimNorgaard/vim-frign",
    lazy = true,
  },
  {
    "gnfisher/tomorrow-night-blue.nvim",
    lazy = true,
  },
  {
    "aidyak/tokusa",
    lazy = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    opts = {
      exclude_groups = { "CursorLine", "LineNr" },
      on_clear = function()
        local strong = "#ffffff"
        local weaker = "#a0a0a0"
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = strong, bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = weaker, bg = "none" })
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-night" } },
}

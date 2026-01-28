---@diagnostic disable: undefined-global
return {
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    enabled = false,
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
      exclude_groups = { "CursorLine" },
      on_clear = function()
        local strong = "#ffffff"
        local weaker = "#a0a0a0"
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = strong, bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}

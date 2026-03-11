return {
  {
    "amedoeyes/eyes.nvim",
    lazy = false,
    priority = 1000,
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
    lazy = true,
  },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    opts = {
      exclude_groups = { "CursorLine" },
      on_clear = function()
        local highlights = {
          "Normal ctermbg=NONE guibg=NONE",
          "NonText ctermbg=NONE guibg=NONE",
          "SpecialKey ctermbg=NONE guibg=NONE",
          "EndOfBuffer ctermbg=NONE guibg=NONE",
          "SignColumn ctermbg=NONE guibg=NONE",
          "NormalNC ctermbg=NONE guibg=NONE",
          "NvimTreeNormal ctermbg=NONE guibg=NONE",
          "MsgArea ctermbg=NONE guibg=NONE",
        }

        for _, hl in ipairs(highlights) do
          vim.cmd("highlight " .. hl)
        end

        local strong = "#ffffff"
        local weaker = "#a0a0a0"
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = strong, bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = weaker, bg = "none" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = weaker, bg = "none" })
        -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "eyes" } },
}

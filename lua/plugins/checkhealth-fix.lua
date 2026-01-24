return {
  {
    "folke/snacks.nvim",
    opts = {
      statuscolumn = { enabled = true },
      image = { enabled = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      -- ensure_installed = { "css", "latex", "norg", "scss", "svelte", "typst", "vue" },
      ensure_installed = { "css", "latex", "scss", "svelte", "typst", "vue" },
    },
  },
}

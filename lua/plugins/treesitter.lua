return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "mks-h/treesitter-autoinstall.nvim" },
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("treesitter-autoinstall").setup()
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      auto_install = true,
      sync_install = false,
      indent = { enable = true },
      highlight = { enable = true },
      ensure_installed = "maintained",
    })
  end,
}

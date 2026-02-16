return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = function()
    vim.treesitter.language.register("markdown", "codecompanion")
    return {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "fish",
        "go",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = false,
          keymaps = {
            ["im"] = "@quad.inner",
            ["am"] = "@quad.outer",
          },
        },
      },
    }
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- LazyVim config for treesitter
    indent = { enable = true }, ---@type lazyvim.TSFeat
    highlight = { enable = true }, ---@type lazyvim.TSFeat
    folds = { enable = true }, ---@type lazyvim.TSFeat
    ensure_installed = {
      "bash",
      "c",
      "css",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "latex",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "typst",
      "vim",
      "vue",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
}

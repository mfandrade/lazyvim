-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
---@diagnostic disable: undefined-global

vim.opt.textwidth = 120

vim.opt.clipboard = "unnamed"

vim.opt.foldlevel = 99
vim.opt.foldtext = ""
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.viewoptions = "folds,cursor"
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "folds" }

-- stylua: ignore start
vim.opt.list = false
vim.opt.listchars = {
  tab      = "» ",
  space    = "·",
  trail    = "⨉",
  nbsp     = "␣",
  extends  = "…",
  precedes = "…",
  eol      = "⏎",
}
vim.opt.showbreak = "↪ "
vim.opt.breakindent = true
-- stylua: ignore end

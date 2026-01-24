-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
---@diagnostic disable: undefined-global

vim.opt.textwidth = 120

-- stylua: ignore start
vim.opt.list = true
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

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Don't sync clipboard with system
vim.opt.clipboard = ""

-- Easier to read file contents
vim.opt.scrolloff = 5

-- Enable modelines for flexibility
vim.opt.modeline = true
vim.opt.modelines = 1

-- Define a list for hidden characters
vim.opt.showbreak = "↳"
vim.opt.listchars = {
  eol = "⏎",
  tab = "› ",
  trail = "·",
  lead = "·",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}
vim.opt.list = false

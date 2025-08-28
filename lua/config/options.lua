-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- don't sync clipboard with system
vim.opt.clipboard = ""

-- tilde is an operator
vim.opt.tildeop = true

-- time to differentiate double strokes keymaps
vim.opt.timeoutlen = 150

-- easier to read file contents
vim.opt.scrolloff = 5

-- enable modelines for flexibility
vim.opt.modeline = true
vim.opt.modelines = 1

-- define a list for hidden characters
vim.opt.showbreak = "↪"
vim.opt.listchars = {
  eol = "⏎",
  tab = "› ",
  trail = "░",
  lead = ".",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}
vim.opt.list = false

-- options to be restored on session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

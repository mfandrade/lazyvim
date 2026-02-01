-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- stylua: ignore start

vim.g.have_nerd_font = true

local conf = vim.opt
conf.clipboard = "unnamed"			 -- Don't sync with system clipboard
conf.mouse = "a"					 -- Enable mouse support for all modes
conf.tildeop = true					 -- Make tilde (~) behave like an operator
conf.updatetime = 250				 -- Faster completion and trigger for CursorHold
conf.timeoutlen = 500				 -- Time to wait for a mapped sequence to complete
conf.scrolloff = 5					 -- Minimum number of lines to keep above/below the cursor
conf.modeline = true				 -- Modelines are useful for per-file settings
conf.modelines = 2					 -- How many lines at bottom/top to check

local line = vim.opt
line.number = true					 -- Show absolute line number
line.relativenumber = true			 -- Show relative line number

local editor = vim.opt
editor.cmdheight = 0				 -- Use 0 lines (moke more room for code)
editor.laststatus = 3				 -- Global status bar (just one in background, regardless splits)
editor.signcolumn = "yes"			 -- Always show the sign column to prevent text shifting
editor.showtabline = 0				 -- Never show the tab line
editor.showmode = false				 -- Hide mode (e.g. -- INSERT --) as it's often in statusline
editor.cursorline = true			 -- Highlight the current line
editor.colorcolumn = "+1"			 -- Draw cursorcolumn 1 char after textwidth

local panes = vim.opt
panes.splitright = true				 -- Vertical splits will automatically be on the right
panes.splitbelow = true				 -- Horizontal splits will automatically be below

local indent = vim.opt
indent.expandtab = true				 -- Convert tabs to spaces
indent.smarttab = true				 -- Make tab inserting smarter
indent.autoindent = true			 -- Copy indent from current line when starting a new one
indent.smartindent = true			 -- Insert indents automatically in specific contexts
indent.list = false					 -- Default to not show invisible chars
indent.listchars = {				 -- How to show invisible chars
  tab      = "» ",
  space    = "·",
  trail    = "⨉",
  nbsp     = "␣",
  extends  = "…",
  precedes = "…",
  eol      = "⏎",
}

local wrapping = vim.opt
wrapping.textwidth = 120			 -- The length of the text that fits in a single line with no wrap (when enabled)
wrapping.wrap = false				 -- No wrap long lines by default
wrapping.breakindent = true			 -- Wrapped lines will retain the same indent
wrapping.showbreak = "↪ "			 -- String to put at the start of lines that have been wrapped

local search = vim.opt
search.ignorecase = true			 -- Ignore case in search patterns
search.smartcase = true				 -- Override 'ignorecase' if search pattern contains upper case
search.inccommand = "nosplit"		 -- Show live preview of substitution in a split window

local folding = vim.opt
folding.fillchars:append({ foldopen = "", foldclose = "", foldsep = "|", fold = " " })
folding.foldtext = ""							 -- Character to connect foldable lines
folding.foldlevel = 99							 -- Open all folds by default
folding.foldcolumn = "0"						 -- Fold will be handled by Snacks
folding.foldmethod = "expr"						 -- Use expression for folding
folding.foldexpr = "v:lua.vim.lsp.foldexpr()"	 -- Use LSP for folding
folding.viewoptions = "folds,cursor"			 -- When using view, folds are persisted
folding.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "folds" }

local undo = vim.opt
undo.undofile = true				 -- Save undo history to a file so it persists after closing
undo.undolevels = 10000				 -- Maximum number of changes that can be undone

-- Backups and swap
local backup = vim.opt
backup.autowriteall = true			 --	To avoid annoying confirmation dialogs
backup.backup = false				 -- Don't create a backup file before overwriting a file
backup.writebackup = false			 -- Don't make a backup before overwriting a file
backup.swapfile = false				 -- Don't use swapfiles (can be risky, but cleaner)

-- stylua: ignore end
-- vim:noet:ts=4:sw=4:sts=4

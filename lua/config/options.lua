-- stylua: ignore start

vim.g.have_nerd_font = true
vim.g.snacks_animate = false

local conf = vim.opt
conf.clipboard = "unnamed"                   -- Don't sync with system clipboard
conf.modelines = 2                           -- How many lines at bottom/top to check
conf.modeline = true                         -- Modelines are useful for per-file settings
conf.spellang = {"en", "pt_br"}              -- Default spell language
conf.tildeop = true                          -- Make tilde (~) behave like an operator
conf.mouse = "a"                             -- Enable mouse support for all modes
conf.timeoutlen = 999                        -- Time to wait for a mapped sequence to complete
conf.updatetime = 250                        -- Faster completion and trigger for CursorHold
conf.winborder = "rounded"                   -- Border setting for neovim 0.11+

local line = vim.opt
line.breakindent = true                      -- Wrapped lines will retain the same indent
line.colorcolumn = ""                        -- There is a custom auto-wrap feature which is disabled by default
line.number = true                           -- Show absolute line number
line.relativenumber = true                   -- Show relative line number
line.showbreak = "" --"↪ "                   -- String to put at the start of lines that have been wrapped
line.textwidth = 120                         -- Length of a single line of text before wrapping (when enabled)
line.wrap = false                            -- No wrap long lines by default

local editor = vim.opt
editor.cmdheight = 1                         -- Use 0 lines (make more room for code)
editor.colorcolumn = "+1"                    -- Draw cursorcolumn 1 char after textwidth
editor.cursorline = true                     -- Highlight the current line
editor.laststatus = 3                        -- Global status bar (just one in background, regardless splits)
editor.scrolloff = 5                         -- Minimum number of lines to keep above/below the cursor
editor.showmode = false                      -- Hide mode (e.g. -- INSERT --) as it's often in statusline
editor.showtabline = 0                       -- Never show the tab line
editor.signcolumn = "yes"                    -- Always show the sign column to prevent text shifting
editor.splitright = true                     -- Vertical splits will automatically be on the right
editor.splitbelow = true                     -- Horizontal splits will automatically be below

local indent = vim.opt
indent.expandtab = true                      -- Convert tabs to spaces
indent.smarttab = true                       -- Make tab inserting smarter
indent.autoindent = true                     -- Copy indent from current line when starting a new one
indent.smartindent = true                    -- Insert indents automatically in specific contexts
indent.list = false                          -- Default to not show invisible chars
indent.listchars = {                         -- How to show invisible chars
  tab      = "» ",
  space    = "·",
  trail    = "⨉",
  nbsp     = "␣",
  extends  = "…",
  precedes = "…",
  eol      = "⏎",
}

_G.custom_fold_text = function()
  local fs = vim.v.foldstart
  local first_line = vim.api.nvim_buf_get_lines(0, fs - 1, fs, false)[1] or ""
  local current_fdm = vim.wo.foldmethod
  if current_fdm == "marker" then
    local marker = vim.opt.foldmarker:get()[1]
    local escaped_marker = marker:gsub("([^%w])", "%%%1")
    first_line = first_line:gsub("%s*" .. escaped_marker .. ".*", "")
  end
  first_line = first_line:gsub("%s+$", "")
  if first_line == "" or first_line:match("^%s*$") then first_line = "..." end
  local line_count = vim.v.foldend - vim.v.foldstart
  local word = line_count == 1 and " line" or " lines"
  return first_line .. "  󰞕 " .. line_count .. word
end

local fold = vim.opt
fold.foldlevel = 99                          -- All fold open by default
fold.foldlevelstart = 99                     -- Fold the first level at first
fold.foldnestmax = 10                        -- Too deep nests doesn't make sense 
fold.foldmethod = "expr"                     -- How the folds are defined
fold.foldtext = "v:lua.custom_fold_text()"   -- What to show in the first line
fold.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- "v:lua.vim.lsp.foldexpr()" 
fold.fillchars:append({ foldopen = "", foldclose = "", foldsep = "", fold = " " })

local undo = vim.opt
undo.undofile = true                         -- Save undo history to a file so it persists after closing
undo.undolevels = 10000                      -- Maximum number of changes that can be undone

local search = vim.opt
search.ignorecase = true                     -- Ignore case in search patterns
search.smartcase = true                      -- Override 'ignorecase' if search pattern contains upper case
search.inccommand = "nosplit"                -- Show live preview of substitution in a split window

local backup = vim.opt
backup.autowriteall = true                   -- To avoid annoying confirmation dialogs
backup.backup = false                        -- Don't create a backup file before overwriting a file
backup.writebackup = false                   -- Don't make a backup before overwriting a file
backup.swapfile = false                      -- Don't use swapfiles (can be risky, but cleaner)

-- stylua: ignore end

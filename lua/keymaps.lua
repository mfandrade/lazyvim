vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function map(keycomb, target, desc, mode, opts)
  local options = opts or { noremap = true, silent = true }
  options.desc = desc
  vim.keymap.set(mode or "n", keycomb, target, options)
end

-- help
-- map("<f1>", function()
--   Snacks.picker.help()
-- end, "Help")
map("<f1><f1>", function()
  local cw = vim.fn.expand("<cword>")
  if cw ~= "" and vim.fn.hlexists(cw) == 0 then
    local ok = cw ~= "" and pcall(function()
      vim.cmd("help " .. cw)
    end)
    if not ok then
      vim.cmd("help")
    end
  end
end, "Help!")

-- normal mode
map("kj", "<esc>", "Escape", "i")
map("0", "^", "Begining of the line (non-blank chars)")
map("00", "0", "Begining of the line")

-- saves and quits
map("<leader>w", "<cmd>write<cr>", "Save")
map("<leader>W", "<cmd>noautocmd write<cr>", "Save (no autocmds)")
map("<leader>q", "<cmd>quit<cr>", "Quit")
map("<leader>Q", "<cmd>quitall!<cr>", "Quit without saving")
map("<leader>X", "<cmd>xit!<cr>", "Save and quit")

-- appends
map(",,", "A,<esc>", "Append ,")
map(";;", "A;<esc>", "Append ;")
map("\\\\", "A \\<esc>", "Append \\")

-- no save to clipboard
map("x", '"_dl', "Delete right char")
map("X", '"_dh', "Delete left char")
map("_", '"_d', "Delete motion")
map("_", '"_d', "Delete selection", "v")
map("__", '"_dd', "Delete line")
map("c", '"_c', "Change motion")
map("c", '"_c', "Change selection", "x")
map("C", '"_c', "Change selection", "x")
map("cc", '"_cc', "Change current line")
map("C", '"_c$', "Change the rest of the line")
map("s", '"_cl', "Substitute char")
map("s", '"_cc', "Substitute selection", "x")
map("S", '"_S', "Substitute line")

-- system clipboard in visual mode
map("D", "d$", "Delete the rest of the line")
map("D", '"+d', "Delete to clipboard", "v")
map("Y", "y$", "Yank the rest of the line")
map("Y", '"+y', "Yank to clipboard", "v")
map("<leader>Y", "<cmd>%yank +<cr>", "Yank all text to clipboard") -- no need to select all text

-- maintain selection
map("<", "<gv", "Indent left", "v")
map(">", ">gv", "Indent right", "v")
map("<", "<<", "Indent left")
map(">", ">>", "Indent right")

-- centralize
map("n", "nzzzv", "Next result")
map("N", "Nzzzv", "Prev result")
map("<c-d>", "<c-d>zz", "Scroll down")
map("<c-u>", "<c-u>zz", "Scroll up")

-- move lines
map("<a-j>", "<cmd>m .+1<cr>==", "Move down")
map("<a-k>", "<cmd>m .-2<cr>==", "Move up")
map("<a-j>", ":m '>+1<cr>gv=gv", "Move lines down", "v")
map("<a-k>", ":m '<-2<cr>gv=gv", "Move lines up", "v")
map("<a-j>", "<esc><cmd>m .+1<cr>==gi", "Move down", "i")
map("<a-k>", "<esc><cmd>m .-2<cr>==gi", "Move up", "i")

-- folding
map("+", "zo", "Open fold")
map("-", "zc", "Close fold")
map("z+", "zR", "Open all folds in file")
map("z-", "zM", "Close all folds in file")

-- splits / vim-tmux-navigator
local function tmux_navigate(direction)
  local win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  if win == vim.api.nvim_get_current_win() then
    local tmux_dir = { h = "L", j = "D", k = "U", l = "R" }
    os.execute("tmux select-pane -" .. tmux_dir[direction])
  end
end
-- stylua: ignore start
map("<c-h>", function() tmux_navigate("h") end, "Navigate left")
map("<c-j>", function() tmux_navigate("j") end, "Navigate down")
map("<c-k>", function() tmux_navigate("k") end, "Navigate up")
map("<c-l>", function() tmux_navigate("l") end, "Navigate right")
-- stylua: ignore end

-- arrows
local keys = { "left", "right", "up", "down", "pageup", "pagedown", "home", "end" }
local modes = { "n", "v", "o", "x", "i", "s" }
for _, mode in ipairs(modes) do
  for _, key in ipairs(keys) do
    map("<" .. key .. ">", "<nop>", "Hard mode", mode)
    map("<c-" .. key .. ">", "<nop>", "Hard mode Ctrl", mode)
  end
end

local arrows = { h = "left", j = "down", k = "up", l = "right" }
local nav_modes = { "v", "o", "x", "i", "s" }
for _, mode in ipairs(nav_modes) do
  for key, dir in pairs(arrows) do
    map("<c-" .. key .. ">", "<" .. dir .. ">", "Cursor " .. dir, mode)
  end
end

-- stylua: ignore start
local function move_no_scrolloff(key)
  local value = vim.o.scrolloff
  vim.opt.scrolloff = 0
  vim.cmd("normal! " .. key)
  vim.opt.scrolloff = value
end
map("H", function() move_no_scrolloff("H") end, "Home line") -- vim.keymap.del("n", "H")
map("L", function() move_no_scrolloff("L") end, "Last line") -- vim.keymap.del("n", "L")
map("'", "<nop>", nil)
map("M", "'", "Go to mark")
-- map("M", "M", "Mid line") -- do it as Hzz or Lzz
-- stylua: ignore end

-- buffer navigation
-- map("<tab>", vim.cmd.bnext, "Next buffer")
-- map("<s-tab>", vim.cmd.bprev, "Prev buffer")
-- for i = 1, 5 do
--   map("<tab>" .. i, function()
--     local bufs = vim.tbl_filter(function(buf)
--       return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
--     end, vim.api.nvim_list_bufs())
--     if bufs[i] then
--       vim.api.nvim_set_current_buf(bufs[i])
--     end
--   end, "Buffer #" .. i)
-- end
-- map("<tab><tab>", function()
--   Snacks.picker.buffers()
-- end, "Open buffers")
--
-- stylua: ignore start
-- Snacks.toggle({ name = "Invisible Chars",
--   get = function() return vim.wo.list end,
--   set = function(state) vim.wo.list = state end,
-- }):map("<leader>uv")

-- Snacks.toggle({ name = "Highlight Cursorline",
--   get = function() return vim.wo.cursorline end,
--   set = function(state) vim.wo.cursorline = state end,
-- }):map("<leader>uH")

-- Snacks.toggle({ name = "Auto-wrap",
--   get = function() return vim.wo.colorcolumn ~= "" end,
--   set = function(state)
--     local tw = vim.bo.textwidth
--     if state then
--       if tw > 0 then
--         vim.opt_local.formatoptions:append({ "t", "c" })
--         vim.wo.colorcolumn = tostring(tw) or "120"
--       end
--     else
--       vim.opt_local.formatoptions:remove({ "t", "c" })
--       vim.wo.colorcolumn = ""
--     end
--   end,
-- }):map("<leader>ua")

-- Snacks.toggle({ name = "Transparency",
--     get = function() return vim.g.transparent_enabled end,
--     set = function(state)
--       if state then vim.cmd("TransparentEnable")
--       else vim.cmd("TransparentDisable") end
--     end,
-- }):map("<leader>ut")

-- Snacks.toggle({ name = "Mini Pairs",
--   get = function() return not vim.g.minipairs_disable end,
--   set = function(state) vim.g.minipairs_disable = not state end,
-- }):map("<leader>uP")
-- -- stylua: ignore end

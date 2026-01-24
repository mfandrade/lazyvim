-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
---@diagnostic disable: undefined-global

local function map(keycomb, target, desc, mode, opts)
  local options = opts or { noremap = true, silent = true }
  options.desc = desc
  vim.keymap.set(mode or "n", keycomb, target, options)
end

-- help
map("<f1>", function()
  local cw = vim.fn.expand("<cword>")
  if cw ~= "" and vim.fn.hlexists(cw) == 0 then
    local ok = cw ~= "" and pcall(function()
      vim.cmd("silent help " .. cw)
    end)
    if not ok then
      vim.api.nvim_input(":help ")
    end
  end
end, "Help")

-- normal mode
map("kj", "<esc>", "Normal mode", "i")

-- quick esc and quick save
map("<leader>w", "<cmd>write<cr>", "Save")
map("<leader>W", "<cmd>noautocmd write<cr>", "Save (no autocmds)")
map("<leader>q", "<cmd>quit<cr>", "Quit")
map("<leader>Q", "<cmd>quitall!<cr>", "Quit without saving")

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
map("C", '"_C', "Change to end of line")
map("s", '"_cl', "Substitute char")
map("s", '"_cc', "Substitute selection", "x")
map("S", '"_S', "Substitute line")

-- system clipboard in visual mode
map("Y", '"+y', "Yank to system clipboard", "v")
map("D", '"+d', "Delete to system clipboard", "v")
map("<leader>Y", "<cmd>%yank +<cr>", "Yank all text to system clipboard") -- no need to select all text

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

-- stylua: ignore start
local function move_no_scrolloff(key)
  local value = vim.o.scrolloff
  vim.opt.scrolloff = 0
  vim.cmd("normal! " .. key)
  vim.opt.scrolloff = value
end
map("H", function() move_no_scrolloff("H") end, "Home line") -- vim.keymap.del("n", "H")
map("L", function() move_no_scrolloff("L") end, "Last line") -- vim.keymap.del("n", "L")
map("M", "M", "Mid line")
-- stylua: ignore end

-- buffer navigation
map("<a-l>", vim.cmd.bnext, "Next buffer")
map("<a-h>", vim.cmd.bprev, "Prev buffer")
for i = 1, 9 do
  local keycomb = string.format("<a-%s>", i)
  local target = string.format("<cmd>BufferLineGoToBuffer %s<cr>", i)
  local desc = string.format("Buffer %s", i)
  map(keycomb, target, desc) -- be sure your terminal sends esc sequences
end

-- stylua: ignore start
-- snacks
Snacks.toggle({ name = "Invisible Chars",
  get = function() return vim.wo.list end,
  set = function(state) vim.wo.list = state end,
}):map("<leader>uv")
Snacks.toggle({ name = "Highlight Cursorline",
  get = function() return vim.wo.cursorline end,
  set = function(state) vim.wo.cursorline = state end,
}):map("<leader>uH")
Snacks.toggle({ name = "Auto-wrap",
  get = function() return vim.wo.colorcolumn ~= "" end,
  set = function(state)
    local tw = vim.bo.textwidth
    if state then
      if tw > 0 then
        vim.opt_local.formatoptions:append({ "t", "c" })
        vim.wo.colorcolumn = tostring(tw) or "120"
      end
    else
      vim.opt_local.formatoptions:remove({ "t", "c" })
      vim.wo.colorcolumn = ""
    end
  end,
}):map("<leader>ua")
-- stylua: ignore end
--

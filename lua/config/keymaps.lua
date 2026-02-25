local function map(keycomb, target, desc, mode, opts)
  local options = opts or { noremap = true, silent = true }
  options.desc = desc
  vim.keymap.set(mode or "n", keycomb, target, options)
end

-- normal mode
map("kj", "<esc>", "Escape", "i")

local f1_timer = nil
map("<f1>", function()
  if f1_timer then
    f1_timer:stop()
    f1_timer = nil
    local cword = vim.fn.expand("<cword>")

    local ok = pcall(function()
      vim.cmd("help " .. (cword ~= "" and cword or "help"))
    end)
    if not ok then
      vim.cmd("help")
    end

    vim.cmd("wincmd p") -- ensure focus help window
    vim.cmd("wincmd w")
  else
    f1_timer = vim.loop.new_timer()
    if f1_timer then
      f1_timer:start(
        250,
        0,
        vim.schedule_wrap(function()
          f1_timer:stop()
          f1_timer = nil
          Snacks.picker.help()
        end)
      )
    end
  end
end, "Smart Help")

-- smart 0
map("0", function()
  local col = vim.fn.col(".")
  local first_nonblank = vim.fn.indent(vim.fn.line(".")) + 1
  if col == first_nonblank then
    return "0"
  else
    return "^"
  end
end, "Begining of the line", "n", { expr = true })

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
map("AA", "GA", "Append to the end of the buffer")

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
map("<leader>Y", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("silent %yank +")
  vim.api.nvim_win_set_cursor(0, curpos)
end, "Yank all text to clipboard")

-- maintain selection
map("<", "<gv", "Indent left", "v")
map(">", ">gv", "Indent right", "v")

-- centralize
map("n", "nzzzv", "Next result")
map("N", "Nzzzv", "Prev result")
map("<c-d>", "<c-d>zz", "Scroll down")
map("<c-u>", "<c-u>zz", "Scroll up")

-- move the viewport
map("J", "<c-e>", "Scroll viewport down")
map("<leader>j", "J", "Join lines")
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      vim.keymap.set("n", "K", "<c-y>", {
        buffer = args.buf,
        desc = "Scroll viewport up",
        remap = false,
      })
      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {
        buffer = args.buf,
        desc = "LSP hover documentation",
      })
    end)
  end,
})

-- move lines
map("<a-j>", "<cmd>move .+1<cr>==", "Move down")
map("<a-k>", "<cmd>move .-2<cr>==", "Move up")
map("<a-j>", ":move '>+1<cr>gv=gv", "Move lines down", "v")
map("<a-k>", ":move '<-2<cr>gv=gv", "Move lines up", "v")
map("<a-j>", "<esc><cmd>move .+1<cr>==gi", "Move down", "i")
map("<a-k>", "<esc><cmd>move .-2<cr>==gi", "Move up", "i")

-- duplicate lines
map("<a-s-j>", "<cmd>copy .<cr>==", "Duplicate down")
map("<a-s-k>", "<cmd>copy .-1<cr>==", "Duplicate up")
map("<a-s-j>", ":copy '> <cr>gv=gv", "Duplicate lines down", "v")
map("<a-s-k>", ":copy '<-1<cr>gv=gv", "Duplicate lines up", "v")
map("<a-s-j>", "<esc><cmd>copy .<cr>==gi", "Duplicate down", "i")
map("<a-s-k>", "<esc><cmd>copy .-1<cr>==gi", "Duplicate up", "i")

-- folding
map("+", "zo", "Open fold")
map("-", "zc", "Close fold")
map("z+", "zR", "Open all folds in file")
map("z-", "zM", "Close all folds in file")

-- vim-tmux-navigator like
local function tmux_navigate(direction)
  local win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  if win == vim.api.nvim_get_current_win() or true then
    local tmux_dir = { h = "L", j = "D", k = "U", l = "R" }
    vim.system({ "tmux", "select-pane", "-" .. tmux_dir[direction] }, { detach = true })
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
for _, key in ipairs(keys) do
  map("<" .. key .. ">", "<nop>", "<nop>", modes)
  -- map("<c-" .. key .. ">", "<nop>", "<nop>", modes)
end

local arrows = { h = "left", j = "down", k = "up", l = "right" }
local nav_modes = { "v", "i" } -- { "v", "o", "x", "i", "s" }
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
map("'", "<nop>", nil) -- avoid conflicting with Tmux prefix
map("M", "'", "Go to line mark") -- do M as Hzz or Lzz instead
-- stylua: ignore end

pcall(vim.keymap.del, "n", "<leader>|")
map("<leader>-", "<C-W>s", "Split Horizontaly")
map("<leader>+", "<C-W>v", "Split Verticaly")

-- stylua: ignore start
map("<leader>fN", "<cmd>enew<cr>", "New file")
map("<leader>fP", function() Snacks.picker.projects() end, "Projects")
-- stylua: ignore end

-- copy file name, path and absolute path
vim.keymap.del("n", "<leader>fn")
vim.keymap.del("n", "<leader>fp")

map("<leader>fn", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied filename: " .. name)
end, "Copy filename")

map("<leader>fp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied file path: " .. path)
end, "Copy file path")

map("<leader>fa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, "Copy absolute path")

-- stylua: ignore start
Snacks.toggle.option("list", { name = "Invisible Chars"
}):map("<leader>uv")

Snacks.toggle.option("cursorline", { name = "Highlight Cursorline"
}):map("<leader>uH")

Snacks.toggle.option("relativenumber", { name = "Relative Number"
}):map("<leader>uL")

map("<leader>uC", function()
  Snacks.picker.colorschemes({
    layout = { preset = "vscode" },
    transform = function(item)
      local runtime = vim.env.VIMRUNTIME:gsub("\\", "/")
      local path = (item.file or ""):gsub("\\", "/")
      if path:find(runtime, 1, true) then return false end
    end,
  })
end, "Colorschemes")

Snacks.toggle({ name = "Auto-wrap",
  get = function() return vim.wo.colorcolumn ~= "" end,
  set = function(state)
    if state then
      if vim.bo.textwidth > 0 then
        vim.opt.formatoptions:append({ "t", "c" })
        vim.wo.colorcolumn = tostring(vim.bo.textwidth) or "120"
      end
    else
      vim.opt.formatoptions:remove({ "t", "c" })
      vim.wo.colorcolumn = ""
    end
  end,
}):map("<leader>ua")

Snacks.toggle({ name = "Transparent Background",
    get = function() return vim.g.transparent_enabled end,
    set = function(state)
      if state then vim.cmd("TransparentEnable")
      else vim.cmd("TransparentDisable") end
    end,
}):map("<leader>uB")

map("<leader>gO", function() -- open room for toggle blame line
  Snacks.gitbrowse()
end, "Git Open Remote in Browser", { "n", "x" })

Snacks.toggle({ name = "Current Blame Line",
  get = function() return require("gitsigns.config").config.current_line_blame end,
  set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
}):map("<leader>gB")
-- stylua: ignore end

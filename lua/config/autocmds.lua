-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- * lazyvim_checktime
-- * lazyvim_highlight_yank
-- * lazyvim_resize_splits
-- * lazyvim_last_loc
-- * lazyvim_close_with_q
-- * lazyvim_man_unlisted
-- * lazyvim_wrap_spell
-- * lazyvim_json_conceal
-- * lazyvim_auto_create_dir

local function augroup(name)
  return vim.api.nvim_create_augroup("autocmds_" .. name, { clear = true })
end

local delautocmd = vim.api.nvim_del_augroup_by_name
local addautocmd = vim.api.nvim_create_autocmd

-- Remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

--delautocmd("lazyvim_close_with_q")
delautocmd("lazyvim_json_conceal")

-- Or add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Change formatoptions to not continue comments on new lines
addautocmd("FileType", {
  group = augroup("format_options"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "o" })
  end,
})

-- Manage cursorline visibility based on window focus
local cursorline_control = augroup("cursorline_control")
addautocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_control,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
addautocmd({ "WinLeave", "BufLeave" }, {
  group = cursorline_control,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Open help files in a floating window
addautocmd("BufWinEnter", {
  group = augroup("floating_help"),
  pattern = "*",
  callback = function()
    local WIDTH = 0.6
    local HEIGHT = 0.6

    if vim.bo.buftype ~= "help" then
      return
    end

    vim.opt_local.scrolloff = 0 -- from now on just options for the help window

    local width = vim.o.columns
    local height = vim.o.lines

    local win_width = math.ceil(width * WIDTH)
    local win_height = math.ceil(height * HEIGHT)
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)

    vim.api.nvim_win_set_config(0, { -- force the current help window to become a float
      relative = "editor",
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })

    local opts = { buffer = true, silent = true, nowait = true }
    vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", opts)
    vim.keymap.set("n", "q", "<cmd>quit<cr>", opts)
  end,
})

-- set textobject for in/around markdown triple backticked codeblocks
addautocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local function select_code_block(inner)
      local ts = vim.treesitter
      local node = ts.get_node()

      -- Search for the block under the cursor
      while node and node:type() ~= "fenced_code_block" do
        node = node:parent()
      end

      -- Search for the next block if necessary
      if not node then
        local ok, parser = pcall(ts.get_parser, 0, "markdown")
        if not ok or not parser then
          return
        end

        local trees = parser:parse()
        if not trees or #trees == 0 then
          return
        end

        local root = trees[1]:root()
        local query = ts.query.parse("markdown", "(fenced_code_block) @block")
        local cursor_row = vim.api.nvim_win_get_cursor(0)[1]

        for _, captured_node in query:iter_captures(root, 0) do
          local start_row = captured_node:range()
          if start_row >= cursor_row - 1 then
            node = captured_node
            break
          end
        end
      end

      if not node then
        return
      end

      local start_row, _, end_row, _ = node:range()

      -- Consistent boundaries (paragraph style)
      local s_row, e_row
      if inner then
        s_row = start_row + 2 -- first line of real code
        e_row = end_row - 1 -- line right BEFORE the last backticks
      else
        s_row = start_row + 1 -- line of initial backticks
        e_row = end_row -- line of final backticks
      end
      -- Protection for empty blocks
      if s_row > e_row and inner then
        return
      end

      -- Clear previous visual selection if it exists
      local mode = vim.api.nvim_get_mode().mode
      if mode:sub(1, 1):lower() == "v" then
        vim.cmd("normal! \27")
      end

      -- Execute the selection movement
      vim.cmd(string.format("normal! %dGV%dG", s_row, e_row))
    end

    vim.keymap.set({ "x", "o" }, "im", function()
      select_code_block(true)
    end, { buffer = true, desc = "``` next code block" })
    vim.keymap.set({ "x", "o" }, "am", function()
      select_code_block(false)
    end, { buffer = true, desc = "``` next code block" })
  end,
})

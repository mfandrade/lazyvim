-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function opts(desc)
  return { silent = true, noremap = true, desc = desc or nil }
end

vim.keymap.set("n", "<C-g>", function()
  local fullpath = vim.fn.expand("%:p") -- full path
  local home = vim.fn.expand("$HOME")

  if fullpath:sub(1, #home) == home then -- Replace home with ~
    fullpath = "~" .. fullpath:sub(#home + 1)
  end

  local parts = vim.split(fullpath, "/", { plain = true })
  local filename = table.remove(parts) -- get the filename

  for i, part in ipairs(parts) do -- abbrev each dir to its first char
    if part ~= "" and part ~= "~" then
      parts[i] = part:sub(1, 1)
    end
  end

  local abbreviated = table.concat(parts, "/") .. "/" .. filename
  print(abbreviated)
end, opts("Show Current File Path"))
-- vim.keymap.set("n", "<C-g>", function() print(vim.fn.expand("%:t")) end, ops ) -- ALT

-- Avoid accidental suspension
vim.keymap.set("n", "<C-z>", "<nop>", opts())

-- Copy to clipboard with capital Y
vim.keymap.set("v", "Y", '"+y', opts("Copy Selected Text to Clipboard"))
vim.keymap.set("n", "YY", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! ^"+yg_')
  vim.api.nvim_win_set_cursor(0, curpos)
end, opts("Copy Text to Clipboard"))

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "kj", "<ESC>", opts("Escape"))
vim.keymap.set("n", "hh", ":w<CR>:echo 'File saved'<CR>", opts("Save File"))
vim.keymap.set("n", "aa", "ggVG", opts("Select All Text"))
vim.keymap.set("n", "AA", 'ggVG"+y', opts("Copy All Text to Clipboard"))
vim.keymap.set("n", "QQ", ":qall<CR>", opts("Quit All"))
vim.keymap.set("n", "0", "^", opts())
vim.keymap.set("n", "00", "0", opts())

vim.keymap.set("n", "M", "'", opts("Go To Mark"))

-- F-keys
vim.keymap.set("n", "<F1>", "<C-u>", opts("Scroll Up Half Screen"))
vim.keymap.set("n", "<F2>", "<C-y>", opts("Scroll Up One Line"))
vim.keymap.set("n", "<F3>", "<C-e>", opts("Scroll Down One Line"))
vim.keymap.set("n", "<F4>", "<C-d>", opts("Scroll Down Half Screen"))
-- F5 = run/continue
-- F6 = dap step into
-- F7 = dap step over
-- F8 = dap step out
vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts("Toggle Breakpoint"))
vim.keymap.set("n", "<Up>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts("Toggle Breakpoint"))

-- format selected code
vim.keymap.set("v", "<leader>cf", function()
  require("conform").format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
  })
end, opts("Format Selected Code"))

-- toggle trailing spaces removal
vim.keymap.set("n", "<leader>t", function()
  vim.g.remove_trailing_spaces = not vim.g.remove_trailing_spaces
  if vim.g.remove_trailing_spaces then
    print("Removing trailing spaces")
  else
    print("Preserving trailing spaces")
  end
end, opts("Toggle Trailing Spaces Removal"))

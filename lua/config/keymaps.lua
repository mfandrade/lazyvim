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

-- Avoid arrow keys
vim.keymap.set("n", "<Up>", ":echoerr 'HJKL!'<CR>", opts())
vim.keymap.set("n", "<Down>", ":echoerr 'HJKL!'<CR>", opts())
vim.keymap.set("n", "<Left>", ":echoerr 'HJKL!'<CR>", opts())
vim.keymap.set("n", "<Right>", ":echoerr 'HJKL!'<CR>", opts())

-- Copy to clipboard with capital Y
vim.keymap.set("v", "Y", '"+y', opts("Copy Selected Text to Clipboard"))
vim.keymap.set("n", "YY", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! ^"+yg_')
  vim.api.nvim_win_set_cursor(0, curpos)
end, opts("Copy Text to Clipboard"))

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "hj", "<ESC>", opts("Escape"))
vim.keymap.set("i", "jh", "<ESC>", opts("Escape"))
vim.keymap.set("n", "hh", ":w<CR>:echo 'File saved'<CR>", opts("Save File"))
vim.keymap.set("n", "aa", "ggVG", opts("Select All Text"))
vim.keymap.set("n", "AA", 'ggVG"+y', opts("Copy All Text to Clipboard"))
vim.keymap.set("n", "QQ", ":qall<CR>", opts("Quit All"))
vim.keymap.set("n", "0", "^", opts())
vim.keymap.set("n", "00", "0", opts())

-- F-keys
vim.keymap.set("n", "<F1>", "<C-e>", opts("Scroll Down One Line"))
vim.keymap.set("n", "<F2>", "<C-y>", opts("Scroll Up One Line"))
vim.keymap.set("n", "<F3>", "<C-d>", opts("Scroll Down Half Screen"))
vim.keymap.set("n", "<F4>", "<C-u>", opts("Scroll Up Half Screen"))
-- F5 = run/continue
-- F6 = dap step into
-- F7 = dap step over
-- F8 = dap step out

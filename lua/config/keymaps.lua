-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ops = { noremap = true, silent = true }

local function fish_style_path()
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
end
vim.keymap.set("n", "<C-g>", fish_style_path, ops)
-- vim.keymap.set("n", "<C-g>", function() print(vim.fn.expand("%:t")) end, ops ) -- ALT

-- Avoid arrow keys
vim.keymap.set("n", "<Up>", ":echoerr 'HJKL!'<CR>", ops)
vim.keymap.set("n", "<Down>", ":echoerr 'HJKL!'<CR>", ops)
vim.keymap.set("n", "<Left>", ":echoerr 'HJKL!'<CR>", ops)
vim.keymap.set("n", "<Right>", ":echoerr 'HJKL!'<CR>", ops)

-- Copy to clipboard with capital Y -- https://stackoverflow.com/a/67890119/2075507
vim.keymap.set({ "n" }, "yY", '^"+y$', ops)
vim.keymap.set({ "n", "v" }, "Y", '"+y', ops)

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "hj", "<ESC>", ops)
vim.keymap.set("n", "jj", ":w<CR>:echo 'File saved'<CR>", ops)
vim.keymap.set("n", "aa", "ggVG", ops)
vim.keymap.set("n", "AA", 'ggVG"+y', ops)
vim.keymap.set("n", "QQ", ":qall<CR>", ops)
vim.keymap.set("n", "0", "^", ops)
vim.keymap.set("n", "00", "0", ops)

-- F-keys
-- F1 = doc underlying symbol
-- F2 = rename
vim.keymap.set("n", "<F3>", "<C-e>", ops)
vim.keymap.set("n", "<F4>", "<C-y>", ops)
-- F5 = dap continue
-- F6 = dap step over
-- F7 = dap step into
-- F8 = ?

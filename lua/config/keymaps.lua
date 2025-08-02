-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local silent = { noremap = true, silent = true }

local function fish_style_path()
  local fullpath = vim.fn.expand("%:p") -- full path
  local home = vim.fn.expand("$HOME")

  -- Replace home with ~
  if fullpath:sub(1, #home) == home then
    fullpath = "~" .. fullpath:sub(#home + 1)
  end

  local parts = vim.split(fullpath, "/", { plain = true })
  local filename = table.remove(parts) -- get the filename

  -- Abbreviate each directory to its first character, except ~
  for i, part in ipairs(parts) do
    if part ~= "" and part ~= "~" then
      parts[i] = part:sub(1, 1)
    end
  end

  local abbreviated = table.concat(parts, "/") .. "/" .. filename
  print(abbreviated)
end

vim.keymap.set("n", "<C-g>", fish_style_path, { noremap = true })
-- vim.keymap.set("n", "<C-g>", function()
--   print(vim.fn.expand("%:t"))
-- end, { noremap = true })

-- Avoid arrow keys
vim.keymap.set("n", "<Up>", ":echoerr 'HJKL!'<CR>", silent)
vim.keymap.set("n", "<Down>", ":echoerr 'HJKL!'<CR>", silent)
vim.keymap.set("n", "<Left>", ":echoerr 'HJKL!'<CR>", silent)
vim.keymap.set("n", "<Right>", ":echoerr 'HJKL!'<CR>", silent)

-- Copy to clipboard with capital Y -- https://stackoverflow.com/a/67890119/2075507
vim.keymap.set({ "n" }, "yY", '^"+y$', silent)
vim.keymap.set({ "n", "v" }, "Y", '"+y', silent)

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "jk", "<ESC>", silent)
vim.keymap.set("n", "kk", ":w<CR>:echo 'File saved'<CR>", silent)
vim.keymap.set("n", "aa", 'ggVG"+y', silent)
vim.keymap.set("n", "QQ", ":qall<CR>", silent)
vim.keymap.set("n", "0", "^", silent)
vim.keymap.set("n", "00", "0", silent)

-- F-keys
-- F1 = doc underlying symbol
-- F2 = rename
vim.keymap.set("n", "<F3>", "<C-e>", silent)
vim.keymap.set("n", "<F4>", "<C-y>", silent)
-- F5 = dap continue
-- F6 = dap step over
-- F7 = dap step into
-- F8 = ?

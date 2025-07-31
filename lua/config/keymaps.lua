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
vim.keymap.set("n", "<Up>", ":echoerr 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ":echoerr 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", ":echoerr 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ":echoerr 'HJKL!'<CR>", { noremap = true, silent = true })

-- Copy to clipboard with capital Y -- https://stackoverflow.com/a/67890119/2075507
vim.keymap.set({ "n" }, "yY", '^"+y$', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "Y", '"+y', { noremap = true, silent = true })

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "kk", ":w<CR>:echo 'File saved'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "aa", 'ggVG"+y', { noremap = true, silent = true })
vim.keymap.set("n", "QQ", ":qall<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "0", "^", { noremap = true, silent = true })
vim.keymap.set("n", "00", "0", { noremap = true, silent = true })

-- As <C-a> is my tmux prefix
vim.keymap.set("n", "+", "<C-a>", { noremap = true, silent = true, desc = "Increment numbers" })
vim.keymap.set("n", "-", "<C-x>", { noremap = true, silent = true, desc = "Decrement numbers" })

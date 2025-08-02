-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local snr = { silent = true, noremap = true }

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
vim.keymap.set("n", "<C-g>", fish_style_path, snr)
-- vim.keymap.set("n", "<C-g>", function() print(vim.fn.expand("%:t")) end, ops ) -- ALT

-- Avoid arrow keys
vim.keymap.set("n", "<Up>", ":echoerr 'HJKL!'<CR>", snr)
vim.keymap.set("n", "<Down>", ":echoerr 'HJKL!'<CR>", snr)
vim.keymap.set("n", "<Left>", ":echoerr 'HJKL!'<CR>", snr)
vim.keymap.set("n", "<Right>", ":echoerr 'HJKL!'<CR>", snr)

-- Copy to clipboard with capital Y
vim.keymap.set("v", "Y", '"+y', snr)
vim.keymap.set("n", "YY", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! ^"+yg_')
  vim.api.nvim_win_set_cursor(0, curpos)
end, snr)

-- Less hand movement -- https://vi.stackexchange.com/a/16969
vim.keymap.set("i", "hj", "<ESC>", snr)
vim.keymap.set("n", "jj", ":w<CR>:echo 'File saved'<CR>", snr)
vim.keymap.set("n", "aa", "ggVG", snr)
vim.keymap.set("n", "AA", 'ggVG"+y', snr)
vim.keymap.set("n", "QQ", ":qall<CR>", snr)
vim.keymap.set("n", "0", "^", snr)
vim.keymap.set("n", "00", "0", snr)

-- F-keys
-- F1 = doc underlying symbol
-- F2 = rename
vim.keymap.set("n", "<F3>", "<C-e>", snr)
vim.keymap.set("n", "<F4>", "<C-y>", snr)
-- F5 = dap continue
-- F6 = dap step over
-- F7 = dap step into
-- F8 = ?

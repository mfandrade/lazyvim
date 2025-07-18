-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Avoid arrow keys
vim.keymap.set("n", "<Up>", ":echo 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ":echo 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", ":echo 'HJKL!'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ":echo 'HJKL!'<CR>", { noremap = true, silent = true })

-- C-w to save file
-- https://stackoverflow.com/a/77783955/2075507
vim.keymap.set(
  { "n" },
  "<C-w>",
  ":w<ENTER>:echo 'File saved'<ENTER>",
  { noremap = true, silent = true, desc = "Save file" }
)

-- Copy to clipboard with capital Y
-- https://stackoverflow.com/a/67890119/2075507
vim.keymap.set({ "n" }, "yY", '^"+y$')
vim.keymap.set({ "n", "v" }, "Y", '"+y')

-- Select all text
-- vim.keymap.set({ "n" }, "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all text" })

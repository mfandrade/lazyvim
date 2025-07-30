-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
vim.keymap.set("n", "ww", ":w<CR>:echo 'File saved'<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "aa", 'ggVG"+y', { noremap = true, silent = true })
vim.keymap.set("n", "QQ", ":qall<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "0", "^", { noremap = true, silent = true })
vim.keymap.set("n", "00", "0", { noremap = true, silent = true })

-- As <C-a> is my tmux prefix
vim.keymap.set("n", "+", "<C-a>", { noremap = true, silent = true, desc = "Increment numbers" })
vim.keymap.set("n", "-", "<C-x>", { noremap = true, silent = true, desc = "Decrement numbers" })

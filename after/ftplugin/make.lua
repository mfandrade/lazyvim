vim.o.ts = 8
vim.o.sts = 8
vim.o.sw = 8
vim.o.si = true
vim.o.list = true
vim.keymap.set("n", "::", "A:<ESC><CR>", { noremap = true, silent = true, desc = "Append a : at the end of the line" })
vim.keymap.set("n", "\\\\", "A\\<ESC><CR>", { noremap = true, silent = true, desc = "Append a \\ at the end of the line" })

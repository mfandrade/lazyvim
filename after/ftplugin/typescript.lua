vim.o.ts = 4
vim.o.sts = 4
vim.o.sw = 4
vim.o.si = true
vim.keymap.set("n", ";;", "A;<ESC><CR>", { noremap = true, silent = true, desc = "Append a ; at the end of the line" })
vim.keymap.set("n", ",,", "A,<ESC><CR>", { noremap = true, silent = true, desc = "Append a , at the end of the line" })

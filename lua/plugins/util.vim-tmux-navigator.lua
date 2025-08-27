return {
  "mfandrade/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
  config = function()
    local opts = { silent = true, noremap = true }
    vim.keymap.set("i", "<c-h>h", "<esc>:TmuxNavigateLeft<cr>", opts)
    vim.keymap.set("i", "<c-j>j", "<esc>:TmuxNavigateDown<cr>", opts)
    vim.keymap.set("i", "<c-k>k", "<esc>:TmuxNavigateUp<cr>", opts)
    vim.keymap.set("i", "<c-l>l", "<esc>:TmuxNavigateRight<cr>", opts)
  end,
}

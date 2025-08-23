return {
  {
    "christoomey/vim-tmux-navigator", -- seemlessly navigation through vim and tmux panes
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>" },
    },
    opts = {
      tmux_navigator_no_wrap = 1,
      tmux_navigator_disable_when_zoomed = 1,
    },
    config = function() end,
  },
}

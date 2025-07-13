return {
  "nil70n/floating-help",
  -- optional
  opts = {
    border = "rounded", -- solid, none, single, double, rounded, shadow
    ratio = 0.6,
  },
  -- -- Now, add a setup function to define the autocommands
  -- config = function()
  --   -- Get the global scrolloff value to restore it later
  --   local original_scrolloff = vim.opt.scrolloff:get()
  --
  --   -- Autocommand to set scrolloff=0 when entering a help buffer
  --   vim.api.nvim_create_autocmd("BufEnter", {
  --     group = vim.api.nvim_create_augroup("FloatingHelpScrolloff", { clear = true }),
  --     pattern = "*.txt", -- Help files usually have .txt extension
  --     callback = function()
  --       -- Check if it's actually a help buffer
  --       if vim.bo.buftype == "help" then
  --         vim.opt_local.scrolloff = 0
  --       end
  --     end,
  --   })
  --
  --   -- Autocommand to restore original scrolloff when leaving a help buffer
  --   vim.api.nvim_create_autocmd("BufLeave", {
  --     group = "FloatingHelpScrolloff",
  --     pattern = "*.txt",
  --     callback = function()
  --       if vim.bo.buftype == "help" then
  --         vim.opt_local.scrolloff = original_scrolloff
  --       end
  --     end,
  --   })
  -- end,
}

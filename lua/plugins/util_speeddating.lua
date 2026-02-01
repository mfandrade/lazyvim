return {
  "tpope/vim-speeddating",
  config = function()
    vim.g.speeddating_no_roman = 0 -- 1 if you want to disable roman support

    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("ignore_speeddating_romans", { clear = true }),
      pattern = "*",
      callback = function()
        if vim.fn.exists(":SpeedDatingFormat") > 0 then
          vim.cmd("SpeedDatingFormat! %v")
          vim.cmd([[SpeedDatingFormat \b[IVXLCDM]\+\b]])
        end
      end,
    })
  end,
}

---@diagnostic disable: undefined-global
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- * lazyvim_checktime
-- * lazyvim_highlight_yank
-- * lazyvim_resize_splits
-- * lazyvim_last_loc
-- * lazyvim_close_with_q
-- * lazyvim_man_unlisted
-- * lazyvim_wrap_spell
-- * lazyvim_json_conceal
-- * lazyvim_auto_create_dir
--
-- Remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_del_augroup_by_name("lazyvim_close_with_q")
vim.api.nvim_del_augroup_by_name("lazyvim_json_conceal")

-- Or add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("FloatingHelp", { clear = true }),
  pattern = "*.txt",
  callback = function()
    local W = 0.6
    local H = 0.8

    if vim.bo.filetype ~= "help" then
      return
    end

    if vim.api.nvim_win_get_config(0).relative ~= "" then
      return
    end

    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_win_close(0, true)

    vim.opt_local.scrolloff = 0
    local stats = vim.api.nvim_list_uis()[1]
    local width = math.floor(stats.width * W)
    local height = math.floor(stats.height * H)

    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((stats.width - width) / 2),
      row = math.floor((stats.height - height) / 2),
      style = "minimal",
      border = "rounded",
    })

    vim.keymap.set("n", "<esc>", ":q<cr>", { buffer = buf, silent = true })
    vim.keymap.set("n", "q", ":q<cr>", { buffer = buf, silent = true })
  end,
})

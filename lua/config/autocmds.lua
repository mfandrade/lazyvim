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

local function augroup(name)
  return vim.api.nvim_create_augroup("autocmds_" .. name, { clear = true })
end

local delautocmd = vim.api.nvim_del_augroup_by_name
local addautocmd = vim.api.nvim_create_autocmd

-- Remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

delautocmd("lazyvim_close_with_q")
delautocmd("lazyvim_json_conceal")

-- Or add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Change formatoptions to not continue comments on new lines
addautocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "o" })
  end,
})

-- Manage cursorline visibility based on window focus
local cursorline_control = augroup("cursorline_control")
addautocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_control,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
addautocmd({ "WinLeave", "BufLeave" }, {
  group = cursorline_control,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Open help files in a floating window
addautocmd("BufWinEnter", {
  group = augroup("floating_help"),
  pattern = "*",
  callback = function()
    local WIDTH = 0.6
    local HEIGHT = 0.6

    if vim.bo.buftype ~= "help" then
      return
    end

    vim.opt_local.scrolloff = 0 -- from now on just options for the help window

    local width = vim.o.columns
    local height = vim.o.lines

    local win_width = math.ceil(width * WIDTH)
    local win_height = math.ceil(height * HEIGHT)
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)

    vim.api.nvim_win_set_config(0, { -- force the current help window to become a float
      relative = "editor",
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })

    local opts = { buffer = true, silent = true, nowait = true }
    vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", opts)
    vim.keymap.set("n", "q", "<cmd>quit<cr>", opts)
  end,
})

-- Make folds persistent
local folds_persistence = augroup("folds_persistence")
addautocmd("BufWritePost", {
  group = folds_persistence,
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd.mkview()
    end
  end,
})

addautocmd("BufWinEnter", {
  group = folds_persistence,
  callback = function()
    if vim.bo.buftype == "" then
      -- Schedule sozinho às vezes falha em arquivos de config
      -- Vamos usar um pequeno delay para garantir que o LSP/Treesitter já "sentou"
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(0) then
          vim.cmd.loadview({ mods = { emsg_silent = true } })
          -- Reaplica o foldtext caso algum plugin tenha resetado
          vim.wo.foldtext = "v:lua.custom_fold_text()"
        end
      end, 50) -- 50ms é imperceptível, mas estabiliza o carregamento
    end
  end,
})

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 80

function _G.fishfold()
  local line = vim.fn.getline(vim.v.lnum)
  -- Fecha fold no 'end'
  if line:match("^%s*end%s*$") then
    return 0
  end
  -- Abre fold em blocos
  if
    line:match("^%s*function%s")
    or line:match("^%s*if%s")
    or line:match("^%s*while%s")
    or line:match("^%s*for%s")
    or line:match("^%s*switch%s")
    or line:match("^%s*begin%s")
  then
    return 1
  end
  -- Herda nível do fold da linha anterior
  return vim.fn.foldlevel(vim.v.lnum - 1)
end

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.fishfold()"

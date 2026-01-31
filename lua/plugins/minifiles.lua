return {
  'echasnovski/mini.files',
  version = '*',
  config = function()
    require('mini.files').setup({
      -- Opções de customização (veja abaixo)
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        use_as_default_explorer = true,
      },
    })
    vim.keymap.set('n', '<leader>f', function()
  if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end, { desc = "Abrir Gerenciador de Arquivos" })
  end
}

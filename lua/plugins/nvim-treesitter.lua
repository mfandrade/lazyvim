return {
  -- Não precisamos de um plugin específico aqui, apenas configuramos o vim.diagnostic
  "nvim-treesitter/nvim-treesitter", -- Exemplo de um plugin que muitas vezes lida com diagnósticos, mas a config é global
  -- Você pode usar 'lazy.nvim' para garantir que isso seja carregado após os plugins de diagnóstico
  -- Ou simplesmente coloque-o como um arquivo de configuração independente se não depender de um plugin específico
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        -- header = false,
        border = "rounded",
        focusable = true,
      },
    })
  end,
}

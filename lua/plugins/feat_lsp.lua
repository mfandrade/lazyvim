return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Interceptamos o setup para garantir que o nosso K ganhe a briga
    opts.setup = opts.setup or {}
    opts.setup["*"] = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          -- O schedule garante que isso rode DEPOIS que o LazyVim aplicar os padrões dele
          vim.schedule(function()
            local keyopts = { desc = "Scroll viewport up", buffer = args.buf, noremap = true, silent = true }
            vim.keymap.set("n", "K", "<C-y>", keyopts)
          end)
        end,
      })
    end
  end,
}

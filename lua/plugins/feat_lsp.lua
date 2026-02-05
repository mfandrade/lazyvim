return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.setup = opts.setup or {}
    opts.setup["*"] = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.schedule(function()
            local keyopts = { buffer = args.buf, noremap = true, silent = true }

            keyopts.desc = "Scroll viewport up"
            vim.keymap.set("n", "K", "<C-y>", keyopts)

            keyopts.desc = "Scroll viewport down"
            vim.keymap.set("n", "J", "<C-e>", keyopts)
          end)
        end,
      })
    end
  end,
}

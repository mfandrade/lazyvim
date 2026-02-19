---@diagnostic disable: missing-fields
return {
  {
    "vim-test/vim-test",
    -- dependencies = { "preservim/vimux" },
    -- stylua: ignore
    config = function()
      vim.cmd("let test#strategy = 'neovim'")
      vim.keymap.set("n", "<leader>Tl", "<cmd>TestLast<cr>", { silent = true, noremap = true, desc = "vim-test Last" })
      vim.keymap.set( "n", "<leader>Tr", "<cmd>TestNearest<cr>", { silent = true, noremap = true, desc = "vim-test Nearest" })
      vim.keymap.set("n", "<leader>Tt", "<cmd>TestFile<cr>", { silent = true, noremap = true, desc = "vim-test File" })
      vim.keymap.set( "n", "<leader>TT", "<cmd>TestSuite<cr>", { silent = true, noremap = true, desc = "vim-test Suite" })
      -- vim.keymap.set("n", "<leader>Tv", "<cmd>TestVisit<cr>", { silent = true, noremap = true, desc = "vim-test Visit" })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            jestArguments = function(defaultArguments)
              return defaultArguments
            end,
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
        },
      })
    end,
  },
}

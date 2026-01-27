return {
  "yetone/avante.nvim",
  opts = {
    provider = "gemini",
    behaviour = {
      auto_set_keymaps = false,
    },
    mappings = {
      submit = { normal = "<cr>", insert = "<s-cr>" },
    },
  },
  keys = {
    -- 1. Seus mapeamentos solicitados
    { "<leader>aa", "<cmd>AvanteToggle<cr>", desc = "avante: ask" },
    { "<leader>an", "<cmd>AvanteChatNew<cr>", desc = "avante: new chat" },
    { "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "avante: history" },
    { "<leader>ac", "<cmd>AvanteClear<cr>", desc = "avante: clear" },
    { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "avante: refresh" },
    { "<leader>ai", "<cmd>AvanteEdit<cr>", desc = "avante: inline edit" },
    { "<leader>aM", "<cmd>AvanteModel<cr>", desc = "avante: switch model" },
    -- { "<leader>aP", "<cmd>AvanteSwitchProvider<cr>", desc = "avante: switch provider" },

    -- 2. Anulando explicitamente os mapeamentos padrão do LazyVim para limpar o menu
    { "<leader>ae", false },
    { "<leader>af", false },
    { "<leader>am", false },
    { "<leader>ap", false },
    { "<leader>as", false },
    { "<leader>at", false },
  },
}

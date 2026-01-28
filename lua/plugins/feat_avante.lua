---@diagnostic disable: undefined-global
return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  opts = {
    provider = "copilot",
    selection = {
      hint_display = "none",
    },
    behaviour = {
      auto_set_keymaps = false,
    },
    mapping = {
      submit = {
        normal = "<CR>",
        insert = "<S-CR>",
      },
    },
  },
  cmd = {
    -- "AvanteAsk",
    -- "AvanteBuild",
    -- "AvanteChat",
    "AvanteClear",
    "AvanteEdit",
    -- "AvanteFocus",
    "AvanteHistory",
    "AvanteModels",
    "AvanteRefresh",
    -- "AvanteShowRepoMap",
    -- "AvanteStop",
    -- "AvanteSwitchProvider",
    "AvanteToggle",
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteToggle<CR>", desc = "Avante: ask" },
    -- { "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
    { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Avante: edit" },
    -- { "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
    { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante: history" },
    { "<leader>am", "<cmd>AvanteModels<CR>", desc = "Avante: select model" },
    { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "Avante: new chat" },
    { "<leader>ac", "<cmd>AvanteClear<CR>", desc = "Avante: clear" },
    -- { "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
    { "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Avante: refresh" },
    -- { "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
    -- { "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
  },
}

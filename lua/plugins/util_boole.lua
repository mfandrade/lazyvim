return {
  "nat-418/boole.nvim",
  event = "VeryLazy",
  config = function()
    require("boole").setup({
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "start", "end" },
        { "BEGIN", "END" },
      },
      allow_caps_additions = {
        { "on", "off" }, -- Ramon
        { "true", "false" },
      },
    })
  end,
}

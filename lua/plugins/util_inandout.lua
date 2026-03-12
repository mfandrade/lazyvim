return {
  "ysmb-wtsg/in-and-out.nvim",
  event = "InsertEnter",
  opts = {
    additional_targets = { "“", "”", "‘", "’" },
  },
  keys = {
    {
      "<s-tab>",
      function()
        require("in-and-out").in_and_out()
      end,
      mode = "i",
      desc = "In and out",
    },
  },
}

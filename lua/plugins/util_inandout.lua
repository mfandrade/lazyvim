return {
  "ysmb-wtsg/in-and-out.nvim",
  -- stylua: ignore
  keys = {
    { "<c-.>", function() require("in-and-out").in_and_out() end, mode = "i", desc = "In and out", },
  },
  config = function()
    require("in-and-out").setup({})
  end,
}

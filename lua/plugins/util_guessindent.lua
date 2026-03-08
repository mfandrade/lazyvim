return {
  "nmac427/guess-indent.nvim",
  lazy = false,
  config = function()
    require("guess-indent").setup({
      auto_cmd = true,
      override_editorconfig = true,
    })
  end,
}
-- return {
--   "Darazaki/indent-o-matic",
--   lazy = false,
--   config = function()
--     require("indent-o-matic").setup({
--       max_lines = 1024,
--     })
--   end,
-- }

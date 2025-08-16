return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        require("snacks").toggle.option("list", { name = "Invisible Chars" }):map("<leader>uv")
        require("snacks").toggle
          .new({
            id = "transparent_toggle",
            name = "Transparent Background",
            get = function()
              local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
              return bg == nil
            end,
            set = function(state)
              vim.cmd("TransparentToggle")
            end,
          })
          :map("<leader>uB")
      end,
    })
  end,
}

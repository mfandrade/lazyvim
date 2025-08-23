return {
  "folke/snacks.nvim",
  dependencies = {
    "xiyaowong/transparent.nvim",
    "xiyaowong/virtcolumn.nvim",
  },
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        header = [[

                                                                         
         ████ ██████           █████      ██                       
        ███████████             █████                               
        █████████ ███████████████████ ███   ███████████     
       █████████  ███    █████████████ █████ ██████████████     
      █████████ ██████████ █████████ █████ █████ ████ █████     
    ███████████ ███    ███ █████████ █████ █████ ████ █████    
   ██████  █████████████████████ ████ █████ █████ ████ ██████   
]],
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- <leader>uv - Invisible Chars
        require("snacks").toggle.option("list", { name = "Invisible Chars" }):map("<leader>uv")

        -- <leader>uB - Transparent Background
        require("snacks").toggle
          .new({
            id = "transparent_toggle",
            name = "Transparent Background",
            get = function()
              local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
              return bg == nil
            end,
            ---@diagnostic disable-next-line: unused-local
            set = function(state)
              vim.cmd("TransparentToggle")
            end,
          })
          :map("<leader>uB")

        -- <leader>ut - Highlight Trailing Spaces
        require("snacks").toggle
          .new({
            id = "highlight_trailingspaces_toggle",
            name = "Trailing Spaces Highlight",
            get = function()
              return vim.b.highlight_trailingspaces
            end,
            set = function(state)
              vim.b.highlight_trailingspaces = state
              if state then
                vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#512D2D" })
                vim.cmd([[match TrailingWhitespace /\s\+$/]])
              else
                vim.cmd([[match none]])
              end
            end,
          })
          :map("<leader>ut")

        -- <leader>u| - Virtual Column
        vim.g.virtualcolumns = vim.g.virtualcolumns or "120"
        require("snacks").toggle
          .new({
            id = "virtcolumns_toggle",
            name = "Virtual Columns = " .. vim.g.virtualcolumns,
            get = function()
              return vim.g.virtualcolumns_enabled or false
            end,
            set = function(state)
              local wrap = vim.wo.wrap
              if state then
                vim.cmd("set colorcolumn=" .. vim.g.virtualcolumns)
                vim.g.virtualcolumns_enabled = true
                if wrap then
                  vim.opt.textwidth = tonumber(vim.g.virtualcolumns)
                  vim.opt.formatoptions:append("t")
                end
              else
                vim.cmd("set colorcolumn=")
                vim.g.virtualcolumns_enabled = false
                vim.opt.textwidth = 0
                vim.opt.formatoptions:remove("t")
              end
            end,
          })
          :map("<leader>u|")
      end,
    })
  end,
}

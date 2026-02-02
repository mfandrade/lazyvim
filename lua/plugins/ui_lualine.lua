return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }
      opts.options.globalstatus = true

      -- stylua: ignore
      opts.sections.lualine_a = { { "mode", fmt = function(str) return " " .. str:sub(1, 3):upper() end, } }
      opts.sections.lualine_b = { "branch" }

      opts.sections.lualine_y = {
        function()
          local bufid = vim.api.nvim_get_current_buf()
          local total = #vim.fn.getbufinfo({ buflisted = 1 })
          return string.format(" %d/%d", bufid, total)
        end,
      }
      opts.sections.lualine_z = { "%p%%/%L", "%l:%c" }
    end,
  },
}

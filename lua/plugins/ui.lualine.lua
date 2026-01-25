---@diagnostic disable: undefined-global
local filled = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 ", "󰎸 ", "󰎻 ", "󰎾 " }
local hollow = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 ", "󰎶 ", "󰎹 ", "󰎼 " }

return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }
      opts.options.globalstatus = true

      local function buffer_navigator()
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        local current = vim.api.nvim_get_current_buf()
        local res = {}

        for i, buf in ipairs(bufs) do
          local label
          if buf.bufnr == current then
            label = hollow[i] or (i .. "●")
          else
            label = filled[i] or tostring(i)
          end
          table.insert(res, label)
        end
        return table.concat(res, " ")
      end

    -- stylua: ignore start
    opts.sections.lualine_a = { { "mode", fmt = function(str) return " " .. str:sub(1, 3):upper() end } }
    opts.sections.lualine_b = { "branch" }

    opts.sections.lualine_y = { '%p%%/%L', '%l:%c',  }
    opts.sections.lualine_z = { buffer_navigator, }

      -- stylua: ignore end
    end,
  },
}

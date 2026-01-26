---@diagnostic disable: undefined-global
local hollow = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 " }
local filled = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 " }

return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }
      opts.options.globalstatus = true

      local function buffer_navigator()
        -- Filtro rigoroso para evitar que buffers de IA e ferramentas poluam a lista
        local bufs = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
        end, vim.api.nvim_list_bufs())

        local current = vim.api.nvim_get_current_buf()
        local res = {}
        local max_visible = 5

        for i, bufnr in ipairs(bufs) do
          if i > max_visible then
            table.insert(res, "󱇬") -- Glifo de continuidade
            break
          end

          local label = (bufnr == current) and filled[i] or hollow[i]
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

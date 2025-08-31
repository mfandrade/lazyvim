local theme_name = vim.g.colors_name or "auto"

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  opts = function()
    local ok, theme = pcall(require, "lualine.themes." .. theme_name)
    if ok then
      theme.insert.a.bg = "#990000"
      theme.insert.a.fg = "#CCCCCC"
    end
    return {
      options = {
        theme = ok and theme or "auto",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return string.sub(str, 1, 3):upper()
            end,
          },
        },
        lualine_c = {
          { "fileformat" },
          -- { "filetype" },
          {
            "buffers",
            hide_filename_extension = false,
            mode = 4,
            symbols = {
              modified = " ",
              alternate_file = "",
            },
          },
        },
        lualine_z = {},
      },
    }
  end,
}

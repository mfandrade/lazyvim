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
        lualine_c = {
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
        lualine_x = { "fileencoding", "fileformat" },
      },
    }
  end,
}

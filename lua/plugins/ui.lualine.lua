return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    sections = {
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
  },
}

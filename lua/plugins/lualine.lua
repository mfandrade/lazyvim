return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    sections = {
      lualine_c = {
        { "fileformat" },
        { "filetype" },
        { "filename" },
      },
      lualine_z = {},
    },
    options = { theme = "ayu" },
  },
}

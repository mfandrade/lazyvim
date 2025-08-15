return {
  {
    "nil70n/floating-help",
    opts = {
      border = "rounded", -- solid, none, single, double, rounded, shadow
      ratio = 0.7,
    },
  },
  {
    "nat-418/boole.nvim",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "sun", "mon", "tue", "wed", "thu", "fri", "sat" },
        { "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec" },
      },
      allow_caps_additions = {
        { "true", "false" },
        { "sun", "mon", "tue", "wed", "thu", "fri", "sat" },
        { "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec" },
      },
    },
  },
}

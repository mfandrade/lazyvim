-- lua/plugins/dial.lua
return {
  "monaqa/dial.nvim",
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- 0
      },
    })

    -- Keymaps
    local map = require("dial.map")
    vim.keymap.set("n", "<C-a>", map.inc_normal("default"), { noremap = true })
    vim.keymap.set("n", "<C-x>", map.dec_normal("default"), { noremap = true })
    vim.keymap.set("v", "<C-a>", map.inc_visual("default"), { noremap = true })
    vim.keymap.set("v", "<C-x>", map.dec_visual("default"), { noremap = true })
  end,
}

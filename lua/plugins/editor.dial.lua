-- lua/plugins/dial.lua
return {
  "monaqa/dial.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- 0
        augend.integer.alias.hex, -- 0x00
        augend.semver.alias.semver, -- v2.0.0
        augend.date.alias["%d/%m/%Y"], -- 01/03/2023
        augend.date.alias["%Y-%m-%d"], -- 1999-12-31
        augend.date.alias["%H:%M"], -- 14:00
        augend.date.alias["%H:%M:%S"], -- 00:00:59
        augend.constant.alias.bool, -- true
        augend.constant.new({ elements = { "True", "False" } }),
        augend.constant.new({ elements = { "on", "off" } }),
        augend.constant.new({ elements = { "enable", "disable" } }),
        augend.constant.new({ elements = { "enabled", "disabled" } }),
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

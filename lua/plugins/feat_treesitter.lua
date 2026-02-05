return {
  "nvim-treesitter/nvim-treesitter",
  opts = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        local function select_code_block(inner)
          local ts = vim.treesitter
          local node = ts.get_node()

          -- Search for the block under the cursor
          while node and node:type() ~= "fenced_code_block" do
            node = node:parent()
          end

          -- Search for the next block if necessary
          if not node then
            local ok, parser = pcall(ts.get_parser, 0, "markdown")
            if not ok or not parser then
              return
            end

            local trees = parser:parse()
            if not trees or #trees == 0 then
              return
            end

            local root = trees[1]:root()
            local query = ts.query.parse("markdown", "(fenced_code_block) @block")
            local cursor_row = vim.api.nvim_win_get_cursor(0)[1]

            for _, captured_node in query:iter_captures(root, 0) do
              local start_row = captured_node:range()
              if start_row >= cursor_row - 1 then
                node = captured_node
                break
              end
            end
          end

          if not node then
            return
          end

          local start_row, _, end_row, _ = node:range()

          -- Consistent boundaries (paragraph style)
          local s_row, e_row
          if inner then
            s_row = start_row + 2 -- first line of real code
            e_row = end_row - 1 -- line right BEFORE the last backticks
          else
            s_row = start_row + 1 -- line of initial backticks
            e_row = end_row -- line of final backticks
          end
          -- Protection for empty blocks
          if s_row > e_row and inner then
            return
          end

          -- Clear previous visual selection if it exists
          local mode = vim.api.nvim_get_mode().mode
          if mode:sub(1, 1):lower() == "v" then
            vim.cmd("normal! \27")
          end

          -- Execute the selection movement
          vim.cmd(string.format("normal! %dGV%dG", s_row, e_row))
        end

        vim.keymap.set({ "x", "o" }, "im", function()
          select_code_block(true)
        end, { buffer = true, desc = "Inner Markdown code block" })
        vim.keymap.set({ "x", "o" }, "am", function()
          select_code_block(false)
        end, { buffer = true, desc = "Around Markdown code block" })
      end,
    })
  end,
}

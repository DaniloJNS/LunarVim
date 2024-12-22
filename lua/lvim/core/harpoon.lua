local M = {}


function M.setup()
  local harpoon = require("harpoon")
  harpoon.setup()
  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-x>", function()
        harpoon.ui:select_menu_item({ split = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-t>", function()
        harpoon.ui:select_menu_item({ tabedit = true })
      end, { buffer = cx.bufnr })
    end,
  })

  harpoon:setup({
    buffer_jump = {
      create_list_item = function()
        local buffer_id = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        local cursor = vim.api.nvim_win_get_cursor(0) -- Return cursor position in active window

        local position = {
          buffer = buffer_id,
          cursor = cursor
        }

        return {
          value = string.format("%s:%d", buffer_name, cursor[1]),
          context = position
        }
      end,
      select = function(list_item, _list, _option)
        local tab_windows = vim.api.nvim_tabpage_list_wins(0)
        local session_windows = vim.api.nvim_list_wins()
        local buffer_id = list_item.context.buffer

        local find_win_by_buffer = function(wins, buffer)
          local win_id = nil

          for _, win in pairs(wins) do
            local win_buffer = vim.api.nvim_win_get_buf(win)

            if win_buffer == buffer then
              win_id = win
              break
            end
          end

          return win_id
        end

        local win_id = find_win_by_buffer(tab_windows, buffer_id) or find_win_by_buffer(session_windows, buffer_id)

        if win_id ~= nil then
          vim.api.nvim_set_current_win(win_id)
          vim.api.nvim_win_set_cursor(win_id, list_item.context.cursor)
        end
      end
    }
  })
end

vim.fn.bufnr('#')
return M

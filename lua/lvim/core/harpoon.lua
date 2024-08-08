local M = {}


function M.setup()
  local harpoon = require("harpoon")
  harpoon:setup({
    rspec_test = {
      create_list_item = function()
        return {
          value = "running...",
          context = {}
        }
      end,
      select = function(list_item, list, option)
        vim.notify(list_item.value, vim.log.levels.ERROR)
      end
    }
  })
end

return M

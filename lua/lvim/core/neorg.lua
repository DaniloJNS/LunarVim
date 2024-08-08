local M = {}

local opts = {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = {                -- We added a `config` table!
        icon_preset = "varied", -- And we set our option here.
      },
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
    },
  }
}

function M.setup()
  local status_ok, neorg = pcall(require, "neorg")
  if not status_ok then
    return
  end
  neorg.setup(opts)
end

return M

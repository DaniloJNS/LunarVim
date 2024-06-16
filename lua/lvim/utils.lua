local M = {}
local uv = vim.loop

-- recursive Print (structure, limit, separator)
local function r_inspect_settings(structure, limit, separator)
  limit = limit or 100 -- default item limit
  separator = separator or "." -- indent string
  if limit < 1 then
    print "ERROR: Item limit reached."
    return limit - 1
  end
  if structure == nil then
    io.write("-- O", separator:sub(2), " = nil\n")
    return limit - 1
  end
  local ts = type(structure)

  if ts == "table" then
    for k, v in pairs(structure) do
      -- replace non alpha keys with ["key"]
      if tostring(k):match "[^%a_]" then
        k = '["' .. tostring(k) .. '"]'
      end
      limit = r_inspect_settings(v, limit, separator .. "." .. tostring(k))
      if limit < 0 then
        break
      end
    end
    return limit
  end

  if ts == "string" then
    -- escape sequences
    structure = string.format("%q", structure)
  end
  separator = separator:gsub("%.%[", "%[")
  if type(structure) == "function" then
    -- don't print functions
    io.write("-- lvim", separator:sub(2), " = function ()\n")
  else
    io.write("lvim", separator:sub(2), " = ", tostring(structure), "\n")
  end
  return limit - 1
end

function M.generate_settings()
  -- Opens a file in append mode
  local file = io.open("lv-settings.lua", "w")

  -- sets the default output file as test.lua
  io.output(file)

  -- write all `lvim` related settings to `lv-settings.lua` file
  r_inspect_settings(lvim, 10000, ".")

  -- closes the open file
  io.close(file)
end

--- Returns a table with the default values that are missing.
--- either parameter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function M.apply_defaults(config, default_config)
  config = config or {}
  default_config = default_config or {}
  local new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), config)
  new_config = vim.tbl_deep_extend("keep", new_config, default_config)
  return new_config
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

M.join_paths = _G.join_paths

---Write data to a file
---@param path string can be full or relative to `cwd`
---@param txt string|table text to be written, uses `vim.inspect` internally for tables
---@param flag string used to determine access mode, common flags: "w" for `overwrite` or "a" for `append`
function M.write_file(path, txt, flag)
  local data = type(txt) == "string" and txt or vim.inspect(txt)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, data, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

---Copies a file or directory recursively
---@param source string
---@param destination string
function M.fs_copy(source, destination)
  local source_stats = assert(vim.loop.fs_stat(source))

  if source_stats.type == "file" then
    assert(vim.loop.fs_copyfile(source, destination))
    return
  elseif source_stats.type == "directory" then
    local handle = assert(vim.loop.fs_scandir(source))

    assert(vim.loop.fs_mkdir(destination, source_stats.mode))

    while true do
      local name = vim.loop.fs_scandir_next(handle)
      if not name then
        break
      end

      M.fs_copy(M.join_paths(source, name), M.join_paths(destination, name))
    end
  end
end

--TODO: move functions below to appropriate files

local root_patterns = { ".git", "lua" }

---@param plugin string
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

function M.toggle_opt(option, silent, values)
  local Util = require("lazy.core.util")

  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      Util.info("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

function M.toggle_diagnostics()
  local diagnostics = {
    off = {
      underline = false,
      virtual_text = false,
      signs = false,
    },
    on = {
      virtual_text = true,
      underline = true,
      severity_sort = true,
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = lvim.icons.diagnostics.Error },
          { name = "DiagnosticSignWarn",  text = lvim.icons.diagnostics.Warning },
          { name = "DiagnosticSignHint",  text = lvim.icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo",  text = lvim.icons.diagnostics.Information },
        },
      },
    },
  }
  local Util = require("lazy.core.util")
  vim.g.diagnostics_enabled = not vim.g.diagnostics_enabled
  if vim.g.diagnostics_enabled then
    vim.diagnostic.enable()
    Util.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    Util.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
  vim.diagnostic.config(diagnostics[vim.g.diagnostics_enabled and "on" or "off"])
end

return M

local function signature_winhighlight()
  local status_ok, cmp_config_win = pcall(require, "cmp.config.window")
  local default = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"
  if status_ok then
    return cmp_config_win.bordered().winhighlight
  else
    return default
  end
end

local opts = {
  lsp = {
    progress = {
      enabled = false,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    documentation = {
      view = "hover",
      opts = {
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        position = {
          row = 2,
          col = 0
        },
        lang = "markdown",
        replace = true,
        render = "plain",
        format = { "{message}" },
        win_options = {
          concealcursor = "n",
          winhighlight = signature_winhighlight(),
          conceallevel = 3
        },
      },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
    long_message_to_split = true,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  routes = {
    -- skip search_count messages instead of showing them as virtual text
    {
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    -- always route any messages with more than 20 lines to the split view
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
  }
}
require("noice").setup(opts)

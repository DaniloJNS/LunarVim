require("focus").setup({
  excluded_filetypes = { "toggleterm", "telescope", "terminal", "NvimTree", "mind" },
  cursorline = false,
  signcolumn = false,
  number = false,
  autoresize = { enable = false },
  -- ui = { winhighlight = true },
})

-- By default, the highlight groups are setup as such:
--   hi default link FocusedWindow VertSplit
--   hi default link UnfocusedWindow Normal
-- To change them, you can link them to a different highlight group, see
-- `:help hi-default` for more info.
-- vim.highlight.link('FocusedWindow', 'CursorLine', true)
-- vim.highlight.link('UnfocusedWindow', 'VisualNOS', true)

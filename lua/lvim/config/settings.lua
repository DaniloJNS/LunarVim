local M = {}

M.load_default_options = function()
  local utils = require "lvim.utils"
  local join_paths = utils.join_paths

  local undodir = join_paths(get_cache_dir(), "undo")

  if not utils.is_directory(undodir) then
    vim.fn.mkdir(undodir, "p")
  end

  local default_options = {
    opt = {
      -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
      autowrite = true,                             -- Enable auto write
      backspace = vim.opt.backspace + { "nostop" }, -- Don't stop backspace at insert
      backup = false,                               -- creates a backup file
      clipboard = "unnamedplus",                    -- Connection to the system clipboard
      cmdheight = 0,                                -- hide command line unless needed
      completeopt = { "menuone", "noselect" },      -- Options for insert mode completion
      conceallevel = 3,                             -- Hide * markup for bold and italic
      confirm = true,                               -- Confirm to save changes before exiting modified buffer
      copyindent = true,                            -- Copy the previous indentation on autoindenting
      cursorline = true,                            -- highlight the current line
      expandtab = true,                             -- convert tabs to spaces
      fileencoding = "utf-8",                       -- the encoding written to a file
      fillchars = { eob = " " },                    -- Disable `~` on nonexistent lines
      foldexpr = "",                                -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
      foldmethod = "manual",                        -- folding, set to "expr" for treesitter based folding
      formatoptions = "jcroqlnt",                   -- tcqj
      grepformat = "%f:%l:%c:%m",                   --
      grepprg = "rg, --vimgrep",                    --
      guifont = "FiraCodeNerdFontMono",             --
      hidden = true,                                -- required to keep multiple buffers and open multiple buffers
      history = 100,                                -- Number of commands to remember in a history table
      hlsearch = true,                              -- highlight all matches on previous search pattern
      ignorecase = true,                            -- ignore case in search patterns
      inccommand = "nosplit",                       -- preview incremental substitute
      laststatus = 3,                               -- globalstatus
      list = true,                                  -- Show some invisible characters (tabs...
      listchars = "tab:→ ,eol:↴,trail:⋅,extends:❯,precedes:❮",
      mouse = "a",                                  -- allow the mouse to be used in neovim
      number = true,                                -- set numbered lines
      numberwidth = 4,                              -- set number column width to 2 {default 4}
      preserveindent = true,                        -- Preserve indent structure as much as possible
      pumblend = 10,                                -- Popup blend
      pumheight = 10,                               -- Height of the pop up menu
      relativenumber = false,                       -- Not show relative numberline
      ruler = false,
      scrolloff = 99999,                            -- Number of lines to keep above and below the cursor
      sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
      shadafile = join_paths(get_cache_dir(), "lvim.shada"),
      shiftround = true,              -- Keep cursor in middle screen
      shiftwidth = 2,                 -- the number of spaces inserted for each indentation
      showcmd = false,
      showmode = false,               -- we don't need to see things like -- INSERT -- anymore
      sidescrolloff = 8,              -- minimal number of screen lines to keep left and right of the cursor.
      signcolumn = "yes",             -- always show the sign column, otherwise it would shift the text each time
      smartcase = true,               -- smart case
      smartindent = true,             -- Insert indents automatically
      spelllang = { "en" },           --
      splitbelow = true,              -- force all horizontal splits to go below current window
      splitright = true,              -- force all vertical splits to go to the right of current window
      swapfile = false,               -- creates a swapfile
      tabstop = 2,                    -- insert 2 spaces for a tab
      termguicolors = true,           -- set term gui colors (most terminals support this)
      timeoutlen = 300,               -- time to wait for a mapped sequence to complete (in milliseconds)
      -- timeoutlen = 1000,              -- time to wait for a mapped sequence to complete (in milliseconds)
      title = true,                   -- set the title of window to the value of the titlestring
      undodir = undodir,              -- set an undo directory
      undofile = true,                -- enable persistent undo
      undolevels = 10000,             --
      updatetime = 100,               -- faster completion
      wildmode = "longest:full,full", -- Command-line completion mode
      winminwidth = 5,                -- Minimum window width
      wrap = false,                   -- Disable wrapping of lines longer than the width of window
      writebackup = false,            -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    },
    g = {
      -- mapleader = " ",
      -- maplocalleader = " ",
      markdown_recommended_style = 0, -- Fix markdown indentation settings
      diagnostics_enabled = true,     -- enable diagnostics at start
      status_diagnostics_enabled = true,
      lspkind_status_ok = true,
      heirline_bufferline = true,
      format_on_save = false,
      diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    }
  }

  ---  SETTINGS  ---
  vim.opt.spelllang:append "cjk"                   -- disable spellchecking for asian characters (VIM algorithm does not support it)
  vim.opt.shortmess:append "c"                     -- don't show redundant messages from ins-completion-menu
  vim.opt.shortmess:append "I"                     -- don't show the default intro message
  vim.opt.whichwrap:append "<,>,[,],h,l"
  vim.opt.shortmess:append({ s = true, I = true }) -- disable startup message
  vim.opt.shortmess:append({ W = true, I = true, c = true })


  for scope, table in pairs(default_options) do
    for setting, value in pairs(table) do
      vim[scope][setting] = value
    end
  end

  vim.filetype.add {
    extension = {
      tex = "tex",
      zir = "zir",
      cr = "crystal",
    },
    pattern = {
      ["[jt]sconfig.*.json"] = "jsonc",
    },
  }
end

M.load_headless_options = function()
  vim.opt.shortmess = ""   -- try to prevent echom from cutting messages off or prompting
  vim.opt.more = false     -- don't pause listing when screen is filled
  vim.opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
  vim.opt.columns = 9999   -- set the widest screen possible
  vim.opt.swapfile = false -- don't use a swap file
end

M.load_defaults = function()
  if #vim.api.nvim_list_uis() == 0 then
    M.load_headless_options()
    return
  end
  M.load_default_options()
end

return M

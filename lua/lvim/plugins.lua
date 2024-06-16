-- local require = require("lvim.utils.require").require
local core_plugins = {
  { "folke/lazy.nvim",              tag = "stable" },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    config = function()
      require("mason-lspconfig").setup(lvim.lsp.installer.setup)

      -- automatic_installation is handled by lsp-manager
      local settings = require "mason-lspconfig.settings"
      settings.current.automatic_installation = false
    end,
    lazy = true,
    event = "User FileOpened",
    dependencies = "mason.nvim",
  },
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  { "nvimtools/none-ls.nvim",       lazy = true },
  {
    "williamboman/mason.nvim",
    config = function()
      require("lvim.core.mason").setup()
    end,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = function()
      pcall(function()
        require("mason-registry").refresh()
      end)
    end,
    event = "User FileOpened",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = not vim.startswith(lvim.colorscheme, "tokyonight"),
    config = function()
      require("lvim.core.tokyonight")
    end
  },
  {
    "lunarvim/lunar.nvim",
    lazy = lvim.colorscheme ~= "lunar",
  },
  { "Tastyep/structlog.nvim", lazy = true },

  { "nvim-lua/popup.nvim",    lazy = true },
  { "nvim-lua/plenary.nvim",  cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    want = "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-arecibo.nvim",
      -- {
      --   "nvim-telescope/telescope-frecency.nvim",
      --   dependencies = {
      --     "kkharji/sqlite.lua",
      --   },
      -- },
    },
    lazy = true,
    cmd = "Telescope",
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true, enabled = lvim.builtin.telescope.active },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
    },
  },
  { "hrsh7th/cmp-nvim-lsp",                     lazy = true },
  { "saadparwaiz1/cmp_luasnip",                 lazy = true },
  { "hrsh7th/cmp-buffer",                       lazy = true },
  { "hrsh7th/cmp-path",                         lazy = true },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    enabled = lvim.builtin.cmp and lvim.builtin.cmp.cmdline.enable or false,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require('lvim.core.luasnip')
    end,
    event = "InsertEnter",
    dependencies = {
      "friendly-snippets",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    cond = lvim.builtin.luasnip.sources.friendly_snippets
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    enabled = lvim.builtin.autopairs.active,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    config = function()
      local utils = require "lvim.utils"
      local path = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "nvim-treesitter")
      vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
      require("lvim.core.treesitter").setup()
    end,
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
  },
  -- {{ modules treesitter
  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    want = 'nvim-treesitter/nvim-treesitter',
    event = "User FileOpened",
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    want = 'nvim-treesitter/nvim-treesitter',
    event = "User FileOpened",
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    want = 'nvim-treesitter/nvim-treesitter',
    event = "User FileOpened",
  },
  -- }}

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    enabled = lvim.builtin.nvimtree.active,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  -- Lir
  {
    "tamago324/lir.nvim",
    config = function()
      require("lvim.core.lir").setup()
    end,
    enabled = lvim.builtin.lir.active,
    event = "User DirOpened",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "User FileOpened",
  },
  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("lvim.core.which-key").setup()
    end,
    cmd = "WhichKey",
    event = "VeryLazy",
    enabled = lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("lvim.core.comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "User FileOpened",
    enabled = lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("lvim.core.project").setup()
    end,
    enabled = lvim.builtin.project.active,
    event = "VimEnter",
    cmd = "Telescope projects",
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    enabled = lvim.use_icons,
    lazy = true,
  },

  -- Status Line and Bufferline
  {
    "rebelot/heirline.nvim",
    event = "VimEnter",
    opts = function()
      local status = require "lvim.core.heirline.utils.status"
      return {
        {
          disable_winbar_cb = function(args)
            return not require("lvim.core.heirline.utils.buffer").is_valid(args.buf)
                or status.condition.buffer_matches({
                  buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                  filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
                }, args.buf)
          end,
        },
        statusline = {
          -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode(),
          status.component.git_branch(),
          status.component.file_info { filetype = {}, filename = false, file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        },
        -- winbar = {
        --   -- winbar
        --   init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        --   fallthrough = false,
        --   {
        --     condition = function() return not status.condition.is_active() end,
        --     -- status.component.separated_path(),
        --     status.component.file_info {
        --       file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
        --       file_modified = false,
        --       file_read_only = false,
        --       hl = status.hl.get_attributes("winbarnc", true),
        --       surround = false,
        --       update = "BufEnter",
        --     },
        --   },
        --   status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
        -- },
        -- tabline = { -- bufferline
        --   {
        --     -- file tree padding
        --     condition = function(self)
        --       self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
        --       return status.condition.buffer_matches(
        --         { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
        --         vim.api.nvim_win_get_buf(self.winid)
        --       )
        --     end,
        --     provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
        --     hl = { bg = "tabline_bg" },
        --   },
        --   status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
        --   status.component.fill { hl = { bg = "tabline_bg" } },               -- fill the rest of the tabline with background color
        --   {
        --     -- tab list
        --     condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
        --     status.heirline.make_tablist {                                        -- component for each tab
        --       provider = status.provider.tabnr(),
        --       hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
        --     },
        --     {
        --       -- close button for current tab
        --       provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
        --       hl = status.hl.get_attributes("tab_close", true),
        --       on_click = {
        --         callback = function() require("lvim.core.heirline.utils.buffer").close_tab() end,
        --         name = "heirline_tabline_close_tab_callback",
        --       },
        --     },
        --   },
        -- },
        statuscolumn = vim.fn.has "nvim-0.9" == 1 and {
          status.component.foldcolumn(),
          status.component.fill(),
          status.component.numbercolumn(),
          status.component.signcolumn(),
        } or nil,
      }
    end,
    config = require "lvim.core.heirline",
  },

  -- {
  --   -- "hoob3rt/lualine.nvim",
  --   "nvim-lualine/lualine.nvim",
  --   -- "Lunarvim/lualine.nvim",
  --   config = function()
  --     require("lvim.core.lualine").setup()
  --   end,
  --   event = "VimEnter",
  --   enabled = lvim.builtin.lualine.active,
  -- },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("lvim.core.breadcrumbs").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.breadcrumbs.active,
    -- enabled = false,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    branch = "main",
    event = "User FileOpened",
    enabled = true,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("lvim.core.dap").setup()
    end,
    lazy = true,
    enabled = lvim.builtin.dap.active,
  },

  -- debugger based in DAP for Golang
  {
    "DaniloJNS/nvim-dap-go",
    name = "dap-go",
    want = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
    lazy = true,
    event = "User FileOpened",
    enabled = lvim.builtin.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    want = "nvim-dap",
    config = function()
      require("lvim.core.dap").setup_ui()
    end,
    lazy = true,
    enabled = lvim.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.core.alpha").setup()
    end,
    enabled = lvim.builtin.alpha.active,
    event = "VimEnter",
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    branch = "main",
    init = function()
      require("lvim.core.terminal").init()
    end,
    config = function()
      require("lvim.core.terminal").setup()
    end,
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    keys = lvim.builtin.terminal.open_mapping,
    enabled = lvim.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("lvim.core.illuminate").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.illuminate.active,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("lvim.core.indentlines").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.indentlines.active,
  },

  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if lvim and lvim.colorscheme == "onedarker" then
          require("onedarker").setup()
          lvim.builtin.lualine.options.theme = "onedarker"
        end
      end)
    end,
    lazy = lvim.colorscheme ~= "onedarker",
  },

  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").setup(lvim.builtin.bigfile.config)
      end)
    end,
    enabled = lvim.builtin.bigfile.active,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
  },
  {
    "ojroques/nvim-bufdel",
    name = 'nvim-bufdel',
    event = "BufReadPre",
    config = function()
      require('bufdel').setup {
        next = 'alternate', -- or 'cycle, 'alternate'
        quit = true,        -- quit Neovim when last buffer is closed
      }
    end
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      require("lvim.core.orgmode").setup()
    end,
  },
  {
    "phaazon/mind.nvim",
    name = "mind",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    branch = "v2.2",
    config = function()
      require('mind').setup({
        persistence = {
          state_path = "~/.mind/mind.json",
          data_dir = "~/.mind/data"
        },
        edit = {
          data_extension = ".norg",
          data_header = "* %s"
        },
        ui = {
          width = 30
        }
      })

      -- normal = {
      --   ["<cr>"] = "open_data",
      --   ["<s-cr>"] = "open_data_index",
      --   ["<tab>"] = "toggle_node",
      --   ["<s-tab>"] = "toggle_node",
      --   ["/"] = "select_path",
      --   ["$"] = "change_icon_menu",
      --   c = "add_inside_end_index",
      --   I = "add_inside_start",
      --   i = "add_inside_end",
      --   l = "copy_node_link",
      --   L = "copy_node_link_index",
      --   d = "delete",
      --   D = "delete_file",
      --   O = "add_above",
      --   o = "add_below",
      --   q = "quit",
      --   r = "rename",
      --   R = "change_icon",
      --   u = "make_url",
      --   x = "select",
      -- }

      -- selection = {
      --   ["<cr>"] = "open_data",
      --   ["<s-tab>"] = "toggle_node",
      --   ["/"] = "select_path",
      --   I = "move_inside_start",
      --   i = "move_inside_end",
      --   O = "move_above",
      --   o = "move_below",
      --   q = "quit",
      --   x = "select",
      -- }
    end
  },
  {
    "vimwiki/vimwiki",
    cmd = "VimwikiIndex",
    config = function()
      vim.g.vimwiki_list = { {
        path = "~/vimwiki",
        syntax = "markdown",
        ext = "md"
      } }
    end
  },
  {
    "KabbAmine/zeavim.vim",
    event = "BufReadPost",
    keys = {
      { "<leader>z",         "<cmd>Zeavim<cr>",      desc = "Open zeavim for current word" },
      {
        "<leader>z",
        ":ZeavimV<cr>",
        mode = "v",
        desc =
        "Open zeavim for current selection"
      },
      { "<leader><leader>z", "<cmd>ZVKeyDocset<cr>", desc = "Open zeavim with manual doc set" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat",     event = "VeryLazy" },
  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  -- scroll bar customizable
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require('lvim.core.nvim-scrollbar')
    end,
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true
  },
  -- UI messages maneger
  {
    "folke/noice.nvim",
    name = "noice",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("lvim.core.noice")
    end,
  },
  -- {
  --   "echasnovski/mini.indentscope",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   event = "BufReadPre",
  --   opts = {
  --     -- symbol = "▏",
  --     symbol = "│",
  --     options = { try_as_border = true },
  --   },
  --   config = function(_, opts)
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "terminal" },
  --       callback = function()
  --         vim.b.miniindentscope_disable = true
  --       end,
  --     })
  --     require("mini.indentscope").setup(opts)
  --   end,
  -- },
  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("lvim.core.diffview")
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "BufReadPost",
    dependencies = {
      "tpope/vim-rhubarb",
      "sodapopcan/vim-twiggy",
      "rbong/vim-flog",
      "junegunn/gv.vim",
    },
    keys = {
      { "<leader>gs",  "<cmd>Git<cr>",     desc = "Open git fugitive" },
      { "<leader>gr",  "<cmd>Gread<cr>",   desc = "Open reset file" },
      { "<leader>gb",  "<cmd>G blame<cr>", desc = "Open git blame" },
      { "<leader>gf",  "<cmd>Flog<cr>",    desc = "Open git flog" },
      { "<leader>gvo", "<cmd>GV<cr>",      desc = "Open git visual" },
      { "<leader>gvO", "<cmd>GV<cr>",      desc = "Open git visual for current file" },
    },
  },
  -- {
  --   "beauwilliams/focus.nvim",
  --   config = function()
  --     require("lvim.core.focus")
  --   end,
  -- },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    enable = false,
    config = function()
      vim.o.equalalways = false
      require('windows').setup(
        {
          autowidth = {
            enable = true,
            winwidth = 50,
            filetype = {
              help = 2,
            },
          },
          ignore = {
            buftype = { "quickfix" },
            filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "telescope", "mind" }
          },
          animation = {
            enable = false,
            duration = 300,
            fps = 30,
            easing = "in_out_sine"
          }
        }
      )
    end,
  },
  -- Better tests integration
  {
    "nvim-neotest/neotest",
    event = "BufReadPost",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "DaniloJNS/neotest-rspec",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = "container-run-spec.sh",
          }),
        },
      })
    end,
  },
  -- Help insert documentation
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    config = function()
      require("lvim.core.neogen")
    end,
  },
  -- better diagnosticslist and others
  -- {
  --   "folke/trouble.nvim",
  --   name = "trouble",
  --   cmd = { "TroubleToggle", "Trouble" },
  --   event = "BufReadPost",
  --   opts = { use_diagnostic_signs = true },
  --   disable = true
  -- },
  {
    "folke/todo-comments.nvim",
    name = "todo-comments",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    event = "BufReadPost",
    config = true,
  },
  -- search/replace in multiple files
  {
    name = "nvim-spectre",
    cmd = "Spectre",
    "windwp/nvim-spectre",
  },

  -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
  {
    event = "InsertEnter",
    "andrewradev/splitjoin.vim",
  },
  -- detect indent style (tabs vs. spaces)
  {
    event = "InsertEnter",
    "tpope/vim-sleuth",
  },
  -- endings for html, xml, etc. - ehances surround
  {
    event = "InsertEnter",
    "tpope/vim-ragtag",
  },
  -- substitute, search, and abbreviate multiple variants of a word
  {
    event = "InsertEnter",
    "tpope/vim-abolish",
  },
  -- context-aware pasting
  {
    "sickill/vim-pasta",
    event = "BufReadPre",
  },
  -- multiple cursors
  {
    "mg979/vim-visual-multi",
    event = "BufReadPre",
  },
  -- Better interaction with registrars
  {
    "gennaro-tedesco/nvim-peekup",
    event = "BufReadPost",
  },
  {
    "stevearc/aerial.nvim",
    name = "aerial",
    cmd = { "AerialToggle", "AerialNext", "AerialPrev" },
    want = {
      "treesitter",
      "nvim-lspconfig",
      "navic",
    },
    config = function()
      require("lvim.core.aerial")
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    want = "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
    },
    config = true
  },
  {
    "ggandor/leap.nvim",
    event = "BufReadPost",
    want = "tpope/vim-repeat",
    config = function()
      vim.keymap.set('n', "gs", function()
        local focusable_windows_on_tabpage = vim.tbl_filter(
          function(win) return vim.api.nvim_win_get_config(win).focusable end,
          vim.api.nvim_tabpage_list_wins(0)
        )
        require('leap').leap { target_windows = focusable_windows_on_tabpage }
      end)
      require('leap').add_default_mappings()
    end
  }
}

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local content = vim.fn.readfile(default_snapshot_path)
local default_sha1 = assert(vim.fn.json_decode(content))

-- taken from <https://github.com/folke/lazy.nvim/blob/c7122d64cdf16766433588486adcee67571de6d0/lua/lazy/core/plugin.lua#L27>
local get_short_name = function(long_name)
  local name = long_name:sub(-4) == ".git" and long_name:sub(1, -5) or long_name
  local slash = name:reverse():find("/", 1, true) --[[@as number?]]
  return slash and name:sub(#name - slash + 2) or long_name:gsub("%W+", "_")
end

local get_default_sha1 = function(spec)
  local short_name = get_short_name(spec[1])
  return default_sha1[short_name] and default_sha1[short_name].commit
end

if not vim.env.LVIM_DEV_MODE then
  --  Manually lock the commit hashes of core plugins
  for _, spec in ipairs(core_plugins) do
    spec["commit"] = get_default_sha1(spec)
  end
end

return core_plugins

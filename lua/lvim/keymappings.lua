-- This file is automatically loaded by lazyvim.plugins.config

local M = {}
local mappings = { i = {}, n = {}, v = {}, x = {}, o = {}, s = {}, t = {}, c = {} }
local utils = require "lvim.utils"

-- Standard operations {{
-- fast config
mappings.n["<leader>ec"] = { "<cmd>vsplit ~/.local/share/lunarvim/lvim/init.lua<cr>", desc = "jump for root file config" }

-- quit commands
mappings.n["<leader>qq"] = { "<cmd>qa<cr>", desc = "Quit all" }
mappings.n["Q"] = { "<cmd>qa<cr>", desc = "Quit all" }
mappings.n["qq"] = { "<cmd>bd<cr>", desc = "Quit all" }
mappings.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
-- }}

-- File maneger {{
-- save file
mappings.i["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
mappings.v["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
mappings.n["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
mappings.s["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
-- new file
mappings.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
mappings.n["<leader>fe"] = { "<cmd>NvimTreeToggle<CR>", desc = "Explore NoTree(root dir)" }
mappings.n["<C-o>"] = { "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true }
if utils.has_plugin("neo-tree.nvim") then
  -- mappings.n["<leader>fe"] = {
  --   function()
  --     require("neo-tree.command").execute({ toggle = true, dir = utils.get_root() })
  --   end,
  --   desc = "Explore NoTree(root dir)",
  mappings.n["<leader>e"] = { "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true }
  mappings.n["<C-o>"] = { "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true }
  mappings.n["<leader>E"] = { "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true }
  -- }
end
mappings.n["<leader>fE"] = { "<cmd>Neotree toggle<CR>", desc = "Explorer NeoTree (cwd)" }
-- }}

-- improve coding experience {{
-- better up/down
mappings.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true }
mappings.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true }
-- Better move Lines
mappings.n["<A-n>"] = { ":m .+1<cr>==", desc = "Move down" }
mappings.i["<A-n>"] = { "<Esc>:m .+1<cr>==gi", desc = "Move down" }
mappings.v["<A-n>"] = { ":m '>+1<cr>gv=gv", desc = "Move down" }
mappings.n["<A-m>"] = { ":m .-2<cr>==", desc = "Move up" }
mappings.v["<A-m>"] = { ":m '<-2<cr>gv=gv", desc = "Move up" }
mappings.i["<A-m>"] = { "<Esc>:m .-2<cr>==gi", desc = "Move up" }
-- Search result
mappings.n["gw"] = { "*N" }
mappings.n["<A-n>"] = { ":m .+1<CR>==", desc = "Move down" }
mappings.v["<A-m>"] = { ":m '<-2<CR>gv=gv", desc = "Move up" }
mappings.x["gw"] = { "*N" }

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
mappings.n["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
mappings.x["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
mappings.o["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
mappings.n["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
mappings.x["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
mappings.o["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }

-- better indenting
mappings.v["<"] = { "<gv" }
mappings.v[">"] = { ">gv" }

-- Clear search with <esc>
mappings.i["<esc>"] = { "<cmd>noh<CR><esc>", desc = "Escape and clear hlsearch" }
mappings.n["<esc>"] = { "<cmd>noh<CR><esc>", desc = "Escape and clear hlsearch" }

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
mappings.n["<leader>ur"] =
{ "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", desc = "Redraw / clear hlsearch / diff update" }

if utils.has_plugin("nvim-spectre") then
  mappings.n["<leader>sr"] = { "<cmd>Spectre<CR>", desc = "Replace in files (Spectre)" }
end
-- }}


-- maneger tabs {{
mappings.n["<leader><tab>l"] = { "<cmd>tablast<cr>", desc = "Last Tab" }
mappings.n["<leader><tab>f"] = { "<cmd>tabfirst<cr>", desc = "First Tab" }
mappings.n["<leader><tab><tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" }
mappings.n["<leader><tab>]"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
mappings.n["<leader><tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }
mappings.n["<leader><tab>["] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
-- my friendly tabs
mappings.n["<M-q>"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }
mappings.n["<M-w>"] = { "<cmd>tab sb<cr>", desc = "New Tab" }
mappings.n["<M-e>"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
mappings.n["<M-->"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
-- }}

-- manager windows {{
mappings.n["<leader>ww"] = { "<C-W>p", desc = "Other window" }
mappings.n["<leader>wc"] = { "<C-W>c", desc = "Delete window" }
mappings.n["<leader>ws"] = { "<C-W>s", desc = "Split window below" }
mappings.n["<leader>we"] = { "<C-W>v", desc = "Split window right" }
mappings.n["<leader>-"] = { "<C-W>s", desc = "Split window below" }
mappings.n["<leader>|"] = { "<C-W>v", desc = "Split window right" }

if utils.has_plugin("smart-splits.nvim") then
  -- Better window navigation
  mappings.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  mappings.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  mappings.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  mappings.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }

  -- Resize window using <alt> arrow keys
  mappings.n["<A-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  mappings.n["<A-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  mappings.n["<A-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  mappings.n["<A-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  -- Move to window using the <ctrl> hjkl keys
  mappings.n["<C-h>"] = { "<C-w>h", desc = "Go to left window" }
  mappings.n["<C-j>"] = { "<C-w>j", desc = "Go to lower window" }
  mappings.n["<C-k>"] = { "<C-w>k", desc = "Go to upper window" }
  mappings.n["<C-l>"] = { "<C-w>l", desc = "Go to right window" }
  -- Resize window using <alt> arrow keys
  mappings.n["<A-k>"] = { "<cmd>resize +2<cr>", desc = "Increase window height" }
  mappings.n["<A-j>"] = { "<cmd>resize -2<cr>", desc = "Decrease window height" }
  mappings.n["<A-h>"] = { "<cmd>vertical resize -2<cr>", desc = "Decrease window width" }
  mappings.n["<A-l>"] = { "<cmd>vertical resize +2<cr>", desc = "Increase window width" }
end
-- }}

-- maneger buffers {{
if utils.has_plugin("bufferline.nvim") then
  mappings.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  mappings.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  mappings.n["<TAB>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  mappings.n["<S-TAB>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  mappings.n["[b"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  mappings.n["]b"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
else
  mappings.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
  mappings.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  mappings.n["<TAB>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  mappings.n["[b"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
  mappings.n["]b"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
end
mappings.n["<leader>bb"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }
mappings.n["<leader>`"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }

-- Delete buffers
if utils.has_plugin("nvim-bufdel") then
  mappings.n["<leader>bd"] = { "<cmd>BufDel<CR>", desc = "Close buffer" }
  mappings.n["<leader>bD"] = { "<cmd>BufDel!<CR>", desc = "Force close buffer" }
  mappings.n["<leader>bo"] = { "<cmd>BufDelOthers<CR>", desc = "Delete all others buffers" }
  mappings.n["<leader>ba"] = { "<cmd>BufDelAll<CR>", desc = "Delete all buffers" }
  mappings.n["<leader>bA"] = { "<cmd>BufDelAll!<CR>", desc = "Force delete all buffers" }
else
  mappings.n["<leader>c"] = { "<cmd>bdelete<cr>", desc = "Close buffer" }
  mappings.n["<leader>C"] = { "<cmd>bdelete!<cr>", desc = "Force close buffer" }
end
-- }}

-- Notation maneger {{
if utils.has_plugin("todo-comments") then
  mappings.n["]t"] = { function() require("todo-comments").jump_next() end, desc = "Next todo comment" }
  mappings.n["[t"] = { function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" }
  mappings.n["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" }
  mappings.n["<leader>xT"] = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" }
  mappings.n["<leader>st"] = { "<cmd>TodoTelescope<cr>", desc = "Todo" }
end
-- better writer docs
if utils.has_plugin("neogen") then
  mappings.n["<Leader>nf"] = {
    function() require("neogen").generate({ snippet_engine = "luasnip" }) end,
    desc = "Insert notation for function"
  }
  mappings.n["<Leader>nc"] = {
    function() require("neogen").generate({ snippet_engine = "luasnip", type = "class" }) end,
    desc = "Insert notation for class"
  }
end
-- }}
-- Telescope provider {{
if utils.has_plugin("telescope") then
  --TODO: move for other file
  local function telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
      builtin = params.builtin
      opts = params.opts
      opts = vim.tbl_deep_extend("force", { cwd = utils.get_root() }, opts or {})
      if builtin == "files" then
        if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
          opts.show_untracked = true
          builtin = "git_files"
        else
          builtin = "find_files"
        end
      end
      require("telescope.builtin")[builtin](opts)
    end
  end

  mappings.n["<leader>,"] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" }
  mappings.n["/"] = {
    function() require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({})) end,
    desc = "Find in Files (Grep)"
  }
  mappings.n["<leader>:"] = { "<cmd>Telescope command_history<cr>", desc = "Command History" }
  mappings.n["<leader><leader>"] = { telescope("files"), desc = "Find Files (root dir)" }
  mappings.n["<C-f>"] = { telescope("files"), desc = "Find Files (root dir)" }
  -- files
  mappings.n["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Buffers" }
  mappings.n["<leader>ff"] = { telescope("files"), desc = "Find Files (root dir)" }
  mappings.n["<leader>fF"] = { telescope("files", { cwd = false }), desc = "Find Files (cwd)" }
  mappings.n["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", desc = "Recent" }
  -- git
  mappings.n["<leader>gc"] = { "<cmd>Telescope git_commits<CR>", desc = "commits" }
  mappings.n["<leader>gs"] = { "<cmd>Telescope git_status<CR>", desc = "status" }
  -- search
  mappings.n["<leader>sa"] = { "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" }
  mappings.n["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" }
  mappings.n["<leader>sc"] = { "<cmd>Telescope command_history<cr>", desc = "Command History" }
  mappings.n["<leader>sC"] = { "<cmd>Telescope commands<cr>", desc = "Commands" }
  mappings.n["<leader>sd"] = { "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" }
  mappings.n["<leader>sf"] = { "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Command History" }
  mappings.n["<leader>sg"] = { telescope("live_grep"), desc = "Grep (root dir)" }
  mappings.n["<leader>sG"] = { telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" }
  mappings.n["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", desc = "Help Pages" }
  mappings.n["<leader>sH"] = { "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" }
  mappings.n["<leader>sl"] = { "<cmd>Telescope resume<cr>", desc = "Resume last search" }
  mappings.n["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", desc = "Key Maps" }
  mappings.n["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", desc = "Man Pages" }
  mappings.n["<leader>sm"] = { "<cmd>Telescope marks<cr>", desc = "Jump to Mark" }
  mappings.n["<leader>so"] = { "<cmd>Telescope vim_options<cr>", desc = "Options" }
  mappings.n["<leader>sR"] = { "<cmd>Telescope registers<cr>", desc = "Registers" }
  mappings.n["<leader>sw"] = { telescope("grep_string"), desc = "Word (root dir)" }
  mappings.n["<leader>sW"] = { telescope("grep_string", { cwd = false }), desc = "Word (cwd)" }
  mappings.n["<leader>sp"] = { telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" }
  mappings.n["<leader>ss"] = {
    telescope("lsp_document_symbols", {
      symbols = {
        "Class",
        "Function",
        "Method",
        "Constructor",
        "Interface",
        "Module",
        "Struct",
        "Trait",
        "Field",
        "Property",
      },
    }),
    desc = "Goto Symbol",
  }
end
-- }}

-- LSP {{
if utils.has_plugin("trouble") then
  mappings.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
  mappings.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
end

if utils.has_plugin("navigator") then
  -- code inforamtions
  mappings.i["<M-k>"] = { function() vim.lsp.signature_help() end, desc = "signature_help" }
  mappings.i["<c-k>"] = { vim.lsp.buf.signature_help, desc = "Signature Help" }
  mappings.n["gk"] = { vim.lsp.buf.signature_help, desc = "signature_help" }
  mappings.n["K"] = { vim.lsp.buf.hover, desc = "Hover" }
  -- search code operations
  mappings.n["gr"] = { require("navigator.reference").async_ref, desc = "async_ref" }
  mappings.n["<Leader>gr"] = { require("navigator.reference").reference, desc = "reference" } -- reference deprecated
  mappings.n["gd"] = { require("navigator.definition").definition, desc = "definition" }
  mappings.n["<Space>D"] = { vim.lsp.buf.type_definition, desc = "type_definition" }
  mappings.n["gp"] = { require("navigator.definition").definition_preview, desc = "definition_preview" }
  mappings.n["gD"] = { vim.lsp.buf.declaration, desc = "declaration" }
  mappings.n["gi"] = { vim.lsp.buf.implementation, desc = "implementation" }
  mappings.n["<Leader>gi"] = { vim.lsp.buf.incoming_calls, desc = "incoming_calls" }
  mappings.n["<Leader>go"] = { vim.lsp.buf.outgoing_calls, desc = "outgoing_calls" }
  -- Symbols
  mappings.n["g0"] = { require("navigator.symbols").document_symbols, desc = "document_symbols" }
  mappings.n["gW"] = { require("navigator.workspace").workspace_symbol_live, desc = "workspace_symbol_live" }
  mappings.n["<Leader>gt"] = { require("navigator.treesitter").buf_ts, desc = "buf_ts" }
  mappings.n["<Leader>gT"] = { require("navigator.treesitter").bufs_ts, desc = "bufs_ts" }
  mappings.n["<Leader>ct"] = { require("navigator.ctags").ctags, desc = "ctags" }
  -- Diagnostics
  mappings.n["gL"] = { require("navigator.diagnostics").show_diagnostics, desc = "show_diagnostics" }
  mappings.n["gG"] = { require("navigator.diagnostics").show_buf_diagnostics, desc = "show_buf_diagnostics" }
  mappings.n["]d"] = { vim.diagnostic.goto_next, desc = "next diagnostics" }
  mappings.n["[d"] = { vim.diagnostic.goto_prev, desc = "prev diagnostics" }
  mappings.n["]O"] = { function() vim.diagnostic.set_loclist() end, desc = "diagnostics set loclist" }
  -- code providers
  mappings.n["<Space>cr"] = { require("navigator.rename").rename, desc = "rename" }
  mappings.n["<Space>ca"] = { require("navigator.codeAction").code_action, desc = "code_action" }
  mappings.v["<Space>ca"] = { require("navigator.codeAction").range_code_action, desc = "range_code_action" }
  mappings.n["<Space>cl"] = { require("navigator.codelens").run_action, desc = "run code lens action" }
  mappings.n["<Space>cf"] = { vim.lsp.buf.format, desc = "format" }
  mappings.v["<Space>cf"] = { vim.lsp.buf.format, desc = "range format" }
end
-- JSON FORMATTERS
mappings.n["<leader>js"] = { "<cmd>%!python -m json.tool<cr>", desc = "Format json file" }
-- Telescope providers
if utils.has_plugin('telescope') then
  mappings.n["<Space>cgd"] = { "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" }
  mappings.n["<Space>cgr"] = { "<cmd>Telescope lsp_references<cr>", desc = "References" }
  mappings.n["<Space>cgI"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" }
  mappings.n["<Space>cgt"] = { "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" }
end
-- }}
-- {{ Autocompletion
if utils.has_plugin("LuaSnip") then
  local luaSnip = require("luasnip")
  mappings.i["<C-j>"] = {
    function()
      return luaSnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    end,
    expr = true,
    silent = true
  }
  mappings.s["<C-j>"] = { function() luaSnip.jump(1) end }
  mappings.s["<C-k>"] = { function() luaSnip.jump(-1) end }
end
-- }}

-- DAP {{
-- Add undo break-points
mappings.i[","] = { ",<c-g>u" }
mappings.i["."] = { ".<c-g>u" }
mappings.i[";"] = { ";<c-g>u" }
-- mappings.n["<leader>dra"] = { require("dap-go").debug_with_args, desc = "DAP GO run with args" }
-- mappings.n["<F2>"] = { require('dap').step_into, desc = "Step Into" }
-- mappings.n["<F3>"] = { require('dap').step_over, desc = "Step Over" }
-- mappings.n["<F4>"] = { require('dap').step_out, desc = "Step Out" }
-- mappings.n["<F5>"] = { require('dap').continue, desc = "Continue" }
-- }}
-- {{ Git mappins
mappings.n["<Space>gdo"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diff view" }
mappings.n["<Space>gdR"] = {
  "<cmd>DiffviewOpen origin/master...HEAD<CR>",
  desc = "Open diff view for compare with repository"
}
mappings.n["<Space>gdh"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "Open diff view in history mode" }
-- if utils.has_plugin("gitsigns") then
mappings.n["]h"] = { function() require 'gitsigns'.next_hunk() end, desc = "Next Hunk" }
mappings.n["[h"] = { function() require 'gitsigns'.prev_hunk() end, desc = "Prev Hunk" }
mappings.n["<leader>ghs"] = { ":Gitsigns stage_hunk<CR>", desc = "Stage Hunk" }
mappings.v["<leader>ghs"] = { ":Gitsigns stage_hunk<CR>", desc = "Stage Hunk" }
mappings.n["<leader>ghr"] = { ":Gitsigns reset_hunk<CR>", desc = "Reset Hunk" }
mappings.v["<leader>ghr"] = { ":Gitsigns reset_hunk<CR>", desc = "Reset Hunk" }
mappings.n["<leader>ghS"] = { function() require 'gitsigns'.stage_buffer() end, desc = "Stage Buffer" }
mappings.n["<leader>ghu"] = { function() require 'gitsigns'.undo_stage_hunk() end, desc = "Undo Stage Hunk" }
mappings.n["<leader>ghR"] = { function() require 'gitsigns'.reset_buffer() end, desc = "Reset Buffer" }
mappings.n["<leader>ghp"] = { function() require 'gitsigns'.preview_hunk() end, desc = "Preview Hunk" }
mappings.n["<leader>ghb"] = { function() require 'gitsigns'.blame_line({ full = true }) end, desc = "Blame Line" }
mappings.n["<leader>ghd"] = { function() require 'gitsigns'.diffthis() end, desc = "Diff This" }
mappings.n["<leader>ghD"] = { function() require 'gitsigns'.diffthis("~") end, desc = "Diff This ~" }
mappings.n["<leader>ghtd"] = { function() require 'gitsigns'.toggle_deleted() end, desc = "Toggle diff line~" }
mappings.n["<leader>ghtb"] = {
  function() require 'gitsigns'.toggle_current_line_blame() end,
  desc = "Toggle blame line ~"
}
mappings.o["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "GitSigns Select Hunk" }
mappings.x["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "GitSigns Select Hunk" }
mappings.n["<leader>gg"] = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", desc = "Lazygit" }
-- end
-- }}

-- lazy comands {{
mappings.n["<leader>l"] = { "<cmd>:Lazy<cr>", desc = "Lazy" }
-- }}

-- maneger lists {{
mappings.n["<leader>xl"] = { "<cmd>lopen<cr>", desc = "Open Location List" }
mappings.n["<leader>xq"] = { "<cmd>copen<cr>", desc = "Open Quickfix List" }
-- }}

-- toggle options {{
mappings.n["<leader>uf"] = { "<cmd>LvimToggleFormatOnSave<CR>", desc = "Toggle format on Save" }
mappings.n["<leader>us"] = { function() utils.toggle_opt("spell") end, desc = "Toggle Spelling" }
mappings.n["<leader>uw"] = { function() utils.toggle_opt("wrap") end, desc = "Toggle Word Wrap" }
mappings.n["<leader>ul"] = {
  function()
    utils.toggle_opt("relativenumber", true)
    utils.toggle_opt("number")
  end,
  desc = "Toggle Line Numbers"
}
mappings.n["<leader>ud"] = { utils.toggle_diagnostics, desc = "Toggle Diagnostics" }
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
mappings.n["<leader>uc"] = {
  function() utils.toggle_opt("conceallevel", false, { 0, conceallevel }) end,
  desc = "Toggle Conceal"
}
-- }}

-- Terminal commands {{
-- mappings.n["<leader>gg"] = { function() utils.float_term({ "lazygit" }, { cwd = utils.get_root() }) end, desc = "Lazygit (root dir)" }
-- mappings.n["<leader>gG"] = { function() utils.float_term({ "lazygit" }) end, desc = "Lazygit (cwd)", }
-- -- floating terminal;
-- mappings.n["<leader>ft"] = { function() utils.float_term(nil, { cwd = neovim.get_root() }) end, desc = "Terminal (root dir)", }
-- mappings.n["<leader>fT"] = { function() neovim.float_term() end, desc = "Terminal (cwd)", }
mappings.t["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter Normal Mode" }
-- }}

-- {{ Notifications
if utils.has_plugin("noice") then
  local noice = require("noice")
  mappings.c["<S-Enter>"] = { function() noice.redirect(vim.fn.getcmdline()) end, desc = "Redirect Cmdline" }
  mappings.n["<leader>snl"] = { function() noice.cmd("last") end, desc = "Noice Last Message" }
  mappings.n["<leader>snh"] = { function() noice.cmd("history") end, desc = "Noice History" }
  mappings.n["<leader>sna"] = { function() noice.cmd("all") end, desc = "Noice All" }
  mappings.n["<c-f>"] = {
    function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
    silent = true,
    expr = true,
    desc = "Scroll forward LSP DOC"
  }
  mappings.n["<c-b>"] = {
    function() if not require("noice.lsp").scroll(-4) then return "<c-f>" end end,
    silent = true,
    expr = true,
    desc = "Scroll forward LSP DOC"
  }
end
-- }}
-- {{ better moving
if utils.has_plugin("aerial") then
  mappings.n["ta"] = { "<cmd>AerialToggle<CR>", desc = "Open aerial ui symbols" }
  mappings.n["tn"] = { "<cmd>AerialNext<CR>", desc = "Next symbol" }
  mappings.n["tp"] = { "<cmd>AerialPrev<CR>", desc = "Prev symbol" }
end
-- }}
-- {{ mappings for vim-dadbob
if utils.has_plugin("vim-dadbob") then
  mappings.n["<C-p>u"] = { "<Cmd>DBUIToggle<Cr>", desc = "Toggle UI" }
  mappings.n["<C-p>f"] = { "<Cmd>DBUIFindBuffer<Cr>", desc = "Find buffer" }
  mappings.n["<C-p>r"] = { "<Cmd>DBUIRenameBuffer<Cr>", desc = "Rename buffer" }
  mappings.n["<C-p>q"] = { "<Cmd>DBUILastQueryInfo<Cr>", desc = "Last query info" }
end
-- }}

-- {{ testing
if utils.has_plugin('neotest') then
  mappings.n["<leader>rc"] = { "<cmd> lua require('neotest').run.run()<cr>", desc = "Run currrent test" }
  mappings.n["<leader>rf"] = { "<cmd> lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run currrent file" }
  mappings.n["<leader>rl"] = { "<cmd> lua require('neotest').run.run_last()<cr>", desc = "Run last test" }
  mappings.n["<leader>ra"] = { "<cmd> lua require('neotest').run.attach()<cr>", desc = "Attach test" }
  mappings.n["<leader>rg"] = { "<cmd> lua require('neotest').run.run(vim.fn.getcwd())<cr>", desc = "Run all tests" }
  mappings.n["<leader>ru"] = { "<cmd> lua require('neotest').summary.toggle()<cr>", desc = "Toggle summary" }
  mappings.n["<leader>ro"] = { "<cmd> lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle output" }
  mappings.n["<leader>ri"] = {
    "<cmd> lua require('neotest').output.open({ enter = true })<cr>",
    desc = "Open in line output test"
  }
end
-- }}
-- {{ testing
-- if utils.has_plugin('mind') then
mappings.n["<leader>mo"] = { "<cmd> MindOpenMain<cr>", desc = "Open Mind" }
mappings.n["<leader>mr"] = { "<cmd> MindReloadState<cr>", desc = "Reload Mind State" }
mappings.n["<leader>mc"] = { "<cmd> MindClose<cr>", desc = "Close Mind" }
mappings.n["<leader>mna"] = { "<cmd> lua require('mind').commands.add_above()<cr>", desc = "Add node" }
-- end
-- }}

-- highlights under cursor;
if vim.fn.has("nvim-0.9.0") == 1 then
  mappings.n["<leader>ui"] = { vim.show_pos, desc = "Inspect Pos" }
end

local function map(mode, lhs, rhs, opts)
  -- local keys = require("lazy.core.handler").handlers.keys
  -- do not create the keymap if a lazy keys handler exists
  -- if not keys.active[keys.parse({ lhs, mode = mode }).id] then
  if rhs == nil then
    return
  end
  vim.keymap.set(mode, lhs, rhs, opts)
  -- end
end

-- local map = vim.keymap.set
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base or {}
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", options, keymap_opts)
          keymap_opts[1] = nil
        end
        -- extend the keybinding options with the base provided and set the mapping
        map(mode, keymap, cmd, keymap_opts)
      end
    end
  end
end

function M.load_defaults()
  M.set_mappings(mappings)
end

return M

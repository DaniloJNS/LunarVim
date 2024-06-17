local util = require "lspconfig/util"
return {
  cmd = { "solargraph", "stdio" },
  root_dir = util.root_pattern("Gemfile", ".git"),
  filetypes = { "ruby" },
  formatting = true,
  settings = {
    solargraph = {
      diagnostics     = true,
      autoformat      = false,
      bundlerPath     = "bundle",
      checkGemVersion = true,
      commandPath     = "solargraph",
      completion      = true,
      definitions     = true,
      folding         = true,
      formatting      = false,
      hover           = true,
      logLevel        = "warn",
      references      = true,
      rename          = true,
      symbols         = true,
      transport       = "socket",
      useBundler      = false,
    },
  },
}

local util = require "lspconfig/util"

return {
  -- cmd = { "docker", "compose", "run", "-T", "app", "bundle", "exec", "solargraph", "stdio" },
  cmd = { "solargraph", "stdio" },
  root_dir = util.root_pattern("Gemfile", ".git"),
  filetypes = { "ruby" },
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
      formatting      = true,
      hover           = true,
      logLevel        = "warn",
      references      = true,
      rename          = true,
      symbols         = true,
      transport       = "socket",
      useBundler      = true,
    },
  },
}

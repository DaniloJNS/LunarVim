local M = {}

function M.setup()
  require('orgmode').setup({
    org_agenda_files = { '~/orgfiles/**/*', '~/.mind/data/**/*' },
    org_default_notes_file = '~/orgfiles/refile.org',
  })
end

return M

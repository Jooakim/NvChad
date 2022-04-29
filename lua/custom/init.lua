-- nvim metals
-- local metals_config = require("metals").bare_config()
-- metals_config.init_options.statusBarProvider = "on"
-- metals_config.settings = {
--   gradleScript = '/home/joakim/dev/main/gradlew',
-- }

local cmd = vim.cmd
cmd [[augroup lsp]]
cmd [[au!]]
-- maybe include java here?
cmd [[au FileType scala,sbt lua require("metals").initialize_or_attach({})]]
cmd [[augroup end]]


-- Create a Format function
cmd([[command! Format lua vim.lsp.buf.formatting_sync()]])

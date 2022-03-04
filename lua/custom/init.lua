local map = require("core.utils").map

-- Movement maps
map("n", "<C-l>","<C-W><C-L>")
map("n", "<C-h>","<C-W><C-H>")

map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
map("n", "<leader>ds", ":lua require'dap'.step_into()<CR>")
map("n", "<leader>dn", ":lua require'dap'.step_over()<CR>")
map("n", "<leader>dr", ":lua require'dap'.step_out()<CR>")

map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

map("n", "<leader>dR", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map("n", "<leader>dl", ":lua require'dap'.run_last.open()<CR>")

map("n", "<leader>dm", ":lua require'dap-python'.test_method({justMyCode = false}).open()<CR>") -- todo make this a function that will call correct thing based on file extension
map("n", "<leader>df", ":lua require'dap-python'.test_class()().open()<CR>") -- todo make this a function that will call correct thing based on file extension

map("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>")

map("n", "<leader>dk", ':lua require"dap".up()<CR>')
map("n", "<leader>dj", ':lua require"dap".down()<CR>')

map("n", "<leader>dq", ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>')

map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>')

map("n", "<leader>d?", ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
map("n", "<leader>d/", ":lua require('dap.ui.widgets').hover()<CR>")

-- Telescope mappings
map("n", "<leader>fp", ':Telescope project<CR>')
map("n", "<leader>fr", ':Telescope resume<CR>')

map("n", "<leader>[", ':lua vim.diagnostic.goto_next()<CR>')
map("n", "<leader>]", ':lua vim.diagnostic.goto_prev()<CR>')
-- pydocstring
-- This will remove any existing keybindings inherited from pydocstring
-- The reason is because <C-l> was bound to :Pydocstring which conflicts
-- with movement mappings above
map("n", "<silent> <C-_>", '<Plug>(pydocstring)')

-- nvim metals
local cmd = vim.cmd
cmd [[augroup lsp]]
cmd [[au!]]
-- maybe include java here?
cmd [[au FileType scala,sbt lua require("metals").initialize_or_attach({})]]
cmd [[augroup end]]

local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  gradleScript = '/home/joakim/dev/main/gradlew',
}

-- Create a Format function
cmd([[command! Format lua vim.lsp.buf.formatting_sync()]])

local M = {}

local configs = require "lspconfig/configs"
local util = require "lspconfig/util"

local path = util.path

local function get_python_path(workspace)
   -- Use activated virtualenv.
   if vim.env.VIRTUAL_ENV then
      return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
   end

   -- Find and use virtualenv in workspace directory.
   for _, pattern in ipairs { "*", ".*" } do
      local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
      if match ~= "" then
         return path.join(path.dirname(match), "bin", "python")
      end
   end
   -- Find and use virtualenv from pipenv in workspace directory.
   local match = vim.fn.glob(path.join(workspace, "Pipfile"))
   if match ~= "" then
      local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
      return path.join(venv, "bin", "python")
   end

   -- Find and use virtualenv via poetry in workspace directory.
   local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
   if match ~= "" then
      local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
      return path.join(venv, "bin", "python")
   end

   -- Fallback to system Python.
   return exepath "python3" or exepath "python" or "python"
end

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = {}

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         -- root_dir = vim.loop.cwd,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end
   lspconfig.pyright.setup {
      on_attach = attach,
      capabilities = capabilities,
      -- root_dir = vim.loop.cwd,
      flags = {
         debounce_text_changes = 150,
      },
      before_init = function(_, config)
         config.settings.python.pythonPath = get_python_path(config.root_dir)
      end,
   }

   -- lspservers with special config
   -- nvim_lsp.pyright.setup {
   -- on_init = function(client)
   --   client.config.settings.python.analysis.extrapaths = { "tests" }
   --   client.notify("workspace/didChangeConfiguration")
   --   return true
   -- end
   -- }
end
return M

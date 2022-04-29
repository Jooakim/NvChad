local M = {}
local utils = require('lspconfig/util')
local path = utils.path

local function get_python_path(workspace)
  print("tmp: " .. workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, ".venv"))
  if match ~= "" then
    local venv =  vim.fn.trim(vim.fn.system('cat ' .. match))
    print("venv: " .. venv)
    env_path = path.join("/home/joakim/.virtualenvs", venv, "bin/python")
    print(env_path)
    return env_path
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  if match ~= "" then
     local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
     return path.join(venv, "bin", "python")
  end

end

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require('lspconfig')
  local opts = {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  lspconfig.jdtls.setup(opts)
  lspconfig.jsonls.setup(opts)
  lspconfig.sumneko_lua.setup(opts)
  lspconfig.tsserver.setup(opts)
  lspconfig.svelte.setup(opts)
  -- lspconfig.sourcery.setup(opts)

  opts.root_dir = vim.loop.cwd
  opts.on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end
  lspconfig.pyright.setup(opts)
end
return M

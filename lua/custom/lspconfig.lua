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
end

M.setup_lsp = function(attach, capabilities)
  local lsp_installer = require "nvim-lsp-installer"
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    if server.name == "pyright" then
      opts.root_dir = vim.loop.cwd
      opts.on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
      end

    end
    server:setup(opts)
  end)
end
return M

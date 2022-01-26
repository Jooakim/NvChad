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
   local match = vim.fn.glob(path.join(workspace, ".venv"))
   if match ~= "" then
      local venv =  vim.fn.system('cat ' .. match)
      print("venv: " .. venv)
      return path.join("/home/joakim/.virtualenvs", venv, "bin", "python")
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
  -- local lsp_installer = require "nvim-lsp-installer"
  --
  -- -- Include the servers you want to have installed by default below
  -- local servers = {
  --   "bashls",
  --   "pyright",
  -- }
  --
  -- for _, name in pairs(servers) do
  --   local server_is_found, server = lsp_installer.get_server(name)
  --   if server_is_found and not server:is_installed() then
  --     print("Installing " .. name)
  --     server:install()
  --   end
  -- end
  --
  -- local function on_attach(client, bufnr)
  --   -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
  -- end
  --
  -- local enhance_server_opts = {
    -- Provide settings that should only apply to the "eslintls" server
    -- ["pyright"] = function(opts)
    --   opts.settings = {
    --     python = {
    --       pythonPath = get_python_path(vim.loop.cwd())
    --     }
    --     -- format = {
    --     --   enable = true,
    --     -- },
    --   }
    -- end,
  -- }

  -- lsp_installer.on_server_ready(function(server)
  --   -- Specify the default options which we'll use to setup all servers
  --   local opts = {
  --     on_attach = on_attach,
  --   }
  --   -- if server.name == "pyright" then
  --   --   opts.settings = {
  --   --     python = {
  --   --       pythonPath = get_python_path(vim.loop.cwd())
  --   --     }
  --   --   }
  --   -- end
  --
  --   if enhance_server_opts[server.name] then
  --     -- Enhance the default opts with the server-specific ones
  --     enhance_server_opts[server.name](opts)
  --   end
  --
  --   server:setup(opts)
  -- end)
  --

   -- lspservers with default config

   -- local servers = {"pylsp"}
   --
   -- for _, lsp in ipairs(servers) do
   --    lspconfig[lsp].setup {
   --       on_attach = attach,
   --       capabilities = capabilities,
   --       -- root_dir = vim.loop.cwd,
   --       flags = {
   --          debounce_text_changes = 150,
   --       },
   --    }
   -- end
   lspconfig.pyright.setup {
      on_attach = attach,
      capabilities = capabilities,
      root_dir = vim.loop.cwd,
      flags = {
         debounce_text_changes = 150,
      },
      settings = {
        python = {
          venvPath = '/home/joakim/.virtualenvs'
        }
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
   local lsp_installer = require "nvim-lsp-installer"

   -- lsp_installer.settings {
   --    ui = {
   --       icons = {
   --          server_installed = "﫟" ,
   --          server_pending = "",
   --          server_uninstalled = "✗",
   --       },
   --    },
   -- }

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         root_dir = vim.loop.cwd,
         settings = {
            python = {
              analysis = {
                extraPaths = { "src/" }
              }
            }
         },
      }

      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --     opts.root_dir = function() ... end
      -- end
      if server.name == "pyright" then
          --opts.settings.python.analysis.extraPaths = { "src" }
          --
          opts.settings = {
            ---root_dir = 'src',

            python = {
              pythonPath = get_python_path(vim.loop.cwd()),
              analysis = {
                extraPaths = { "src" }
              }
            }
          }
      end

      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
   end)
end
return M

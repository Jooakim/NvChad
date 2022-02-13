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

local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
  use {
    "martinda/Jenkinsfile-vim-syntax",
    event = "InsertEnter",
  }
  use {
    'williamboman/nvim-lsp-installer',
  }
  use {
    "tpope/vim-fugitive",
    event = "InsertEnter",
  }
  use {
    "cespare/vim-toml",
    event = "InsertEnter",
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugin_confs.null-ls").setup()
    end,
  }
  use {
    "nvim-telescope/telescope-project.nvim",
    requires = { "nvim-telescope/telescope.nvim" }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use {
    'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" }
  }
  use {
    "heavenshell/vim-pydocstring",
    event = "InsertEnter",
  }
  use {
    "mfussenegger/nvim-dap"
  }
  use {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"
      require("dap-python").test_runner = "pytest"
      table.insert(require('dap').configurations.python, {
        type = 'python';
        request = 'attach';
        name = 'Docker Debug';
        host = '127.0.0.1';
        port = 5678;
        pathMappings = {
          {  -- Map Neovim working directory to debuggee working directory
          localRoot = '${workspaceFolder}',
          remoteRoot = '.'
        };
        justMyCode = false;
      },
    })
  end,
}
use {
  "rcarriga/vim-ultest",
  requires = { "vim-test/vim-test" },
  run = ":UpdateRemotePlugins"
}
end)

-- Create a Format function
cmd([[command! Format lua vim.lsp.buf.formatting_sync()]])

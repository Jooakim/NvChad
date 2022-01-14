local map = require("core.utils").map
map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
map("n", "<leader>ds", ":lua require'dap'.step_into()<CR>")
map("n", "<leader>dn", ":lua require'dap'.step_over()<CR>")
map("n", "<leader>dr", ":lua require'dap'.step_out()<CR>")

map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

map("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map("n", "<leader>dl", ":lua require'dap'.run_last.open()<CR>")

map("n", "<leader>dm", ":lua require'dap-python'.test_method({justMyCode = false}).open()<CR>") -- todo make this a function that will call correct thing based on file extension
map("n", "<leader>df", ":lua require'dap-python'.test_class()().open()<CR>") -- todo make this a function that will call correct thing based on file extension

map("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>")

map("n", "<leader>dk", ':lua require"dap".up()<CR>')
map("n", "<leader>dj", ':lua require"dap".down()<CR>')

map("n", "<leader>dq", ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>')

-- map('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>')
-- map('n', '<leader>di', ':lua require"dap.ui.variables".visual_hover()<CR>')
map("n", "<leader>di", ':lua require"dap.ui.widgets".hover()<CR>')
-- map('n', '<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>')
map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>')

map("n", "<leader>d?", ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

-- Telescope mappings
map("n", "<leader>fp", ':lua require("telescope").extensions.project.project{}<CR>')

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
  -- use {
  --   "nvim-telescope/telescope-project.nvim",
  --   event = "InsertEnter",
  --   after = "telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension("project")
  --   end,
  -- }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  -- use {
  --   "nvim-telescope/telescope-github.nvim",
  --   event = "InsertEnter",
  --   after = "telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension "gh"
  --   end,
  -- }
  use {
    "heavenshell/vim-pydocstring",
    event = "InsertEnter",
  }
  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  }
  use {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"
      require("dap-python").test_runner = "pytest"
    end,
  }
end)

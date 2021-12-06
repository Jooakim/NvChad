-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
  --   current.virtual_text = false;
  --   return current;
  -- end)

  -- To add new mappings, use the "setup_mappings" hook,
  -- you can set one or many mappings
  -- example below:

  hooks.add("setup_mappings", function(map)
    map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opt)
    map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)
    map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opt)
    map("n", "<leader>ds", ":lua require'dap'.step_into()<CR>", opt)
    map("n", "<leader>dn", ":lua require'dap'.step_over()<CR>", opt)
    map("n", "<leader>dr", ":lua require'dap'.step_out()<CR>", opt)


    map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opt)

    map('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
    map("n", "<leader>dl", ":lua require'dap'.run_last.open()<CR>", opt)

    map("n", "<leader>dm", ":lua require'dap-python'.test_method({justMyCode = false}).open()<CR>", opt) -- todo make this a function that will call correct thing based on file extension
    map("n", "<leader>df", ":lua require'dap-python'.test_class()().open()<CR>", opt) -- todo make this a function that will call correct thing based on file extension

    map("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", opt)

    map('n', '<leader>dk', ':lua require"dap".up()<CR>')
    map('n', '<leader>dj', ':lua require"dap".down()<CR>')

    map('n', '<leader>dq', ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>')

    -- map('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>')
    -- map('n', '<leader>di', ':lua require"dap.ui.variables".visual_hover()<CR>')
    map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
    -- map('n', '<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>')
    map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')

    map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

    -- Telescope mappings
    map('n', '<leader>fp', ':lua require("telescope").extensions.project.project{}<CR>')


  end)

  -- To add new plugins, use the "install_plugin" hook,
  -- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
  -- see: https://github.com/wbthomason/packer.nvim
  -- examples below:

  hooks.add("install_plugins", function(use)
    use {
      "martinda/Jenkinsfile-vim-syntax",
      event = "InsertEnter",
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
      "kabouzeid/nvim-lspinstall",
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
      event = "InsertEnter",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("project")
      end,
    }
    use {
      "nvim-telescope/telescope-github.nvim",
      event = "InsertEnter",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("gh")
      end,
    }
    use {
      "heavenshell/vim-pydocstring",
      event = "InsertEnter",
    }
    use { 
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require("dapui").setup()
      end,
    }
    use { 
      "mfussenegger/nvim-dap-python",
      config = function()
        require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        require('dap-python').test_runner = 'pytest'
      end,
    }

  end)

  -- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
  -- then source it with

  -- require "custom.plugins.mkdir"

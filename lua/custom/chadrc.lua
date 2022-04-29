local M = {}
-- M.ui, M.options, M.plugin_status, M.mappings, M.custom = {}, {}, {}, {}, {}

-- non plugin ui configs, available without any plugins
M.ui = {
  -- theme to be used, to see all available themes, open the theme switcher by <leader> + th
  theme = "gruvchad",
}
M.mappings = {
  custom = {
    n = {
      -- Movement maps
      ["<C-l>"] = { "<C-W><C-L>", "" },
      ["<C-h>"] = { "<C-W><C-H>", "" },

      ["<leader>b"] = { ":lua require'dap'.toggle_breakpoint()<CR>", "" },
      ["<leader>B"] = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "" },
      ["<leader>dc"] = { ":lua require'dap'.continue()<CR>", "" },
      ["<leader>ds"] = { ":lua require'dap'.step_into()<CR>", "" },
      ["<leader>dn"] = { ":lua require'dap'.step_over()<CR>", "" },
      ["<leader>dr"] = { ":lua require'dap'.step_out()<CR>", "" },

      ["<leader>lp"] = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "" },

      ["<leader>dR"] = { ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', "" },
      ["<leader>dl"] = { ":lua require'dap'.run_last.open()<CR>", "" },

      ["<leader>dm"] = { ":lua require'dap-python'.test_method({justMyCode = false}).open()<CR>", ""},
      ["<leader>df"] = { ":lua require'dap-python'.test_class()().open()<CR>", ""},

      ["<leader>dk"] = { ':lua require"dap".up()<CR>', "" },
      ["<leader>dj"] = { ':lua require"dap".down()<CR>', "" },

      ["<leader>dq"] = { ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>', "" },

      ["<leader>de"] = { ':lua require"dap".set_exception_breakpoints({"all"})<CR>', "" },

      ["<leader>d?"] = { ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>', "" },
      ["<leader>d/"] = { ":lua require('dap.ui.widgets').hover()<CR>", "" },

      -- Telescope mappings
      ["<leader>fp"] = { ':Telescope project<CR>', "" },
      ["<leader>fr"] = { ':Telescope resume<CR>', "" },

      ["<leader>["] = { ':lua vim.diagnostic.goto_next()<CR>', "" },
      ["<leader>]"] = { ':lua vim.diagnostic.goto_prev()<CR>', "" },
      -- pydocstring
      -- This will remove any existing keybindings inherited from pydocstring
      -- The reason is because <C-l> was bound to :Pydocstring which conflicts
      -- with movement mappings above
      ["<silent> <C-_>"] = { '<Plug>(pydocstring)', "" },

      ["<leader>n"] = { ':MagmaEvaluateVisual<CR>', "" },
      ["<leader>nn"] = { ':MagmaEvaluateLine<CR>', "" },
      ["<leader>nc"] = { ':MagmaReevaluateCell<CR>', "" },
      ["<leader>nd"] = { ':MagmaDelete<CR>', "" },
      ["<leader>no"] = { ':MagmaShowOuput<CR>', "" },
    }
  },

  -- magma = {
  --   n = {
  --     ["<silent><expr> <Leader>n "] = { ':MagmaEvaluateOperator', "" },
  --     ["<silent> <Leader>nn "] = { ':MagmaEvaluateLine', "" },
  --     ["<silent> <Leader>nc "] = { ':MagmaReevaluateCell', "" },
  --     ["<silent> <Leader>nd "] = { ':MagmaDelete', "" },
  --     ["<silent> <Leader>no "] = { ':MagmaShowOuput', "" },
  --   },
  --   x = {
  --     ["<silent> <LocalLeader>n"] = {":<C-u>MagmaEvaluateVisual<CR>", ""}
  --   }
  -- }

}

-- enable and disable plugins (false for disable)
M.plugin_status = {
  colorizer = true,
}

local userPlugins = require "custom.plugins" -- path to table
-- NvChad included plugin options & overrides
M.plugins = {

  user = userPlugins,
  options = {
    lspconfig = {
      setup_lspconf = "custom.lspconfig",
    },
  },
  status = {
    vim_matchup = false, -- % operator enhancements
    bufferline = false, -- to autosave files
    esc_insertmode = false,
  },
  default_plugin_config_replace = {
  }
}

--vim.g.pydocstring_formatter = "numpy"
vim.g.pydocstring_doq_path = "/home/joakim/.local/bin/doq"

return M

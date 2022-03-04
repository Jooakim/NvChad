local M = {}
M.ui, M.options, M.plugin_status, M.mappings, M.custom = {}, {}, {}, {}, {}

-- non plugin ui configs, available without any plugins
M.ui = {
  -- theme to be used, to see all available themes, open the theme switcher by <leader> + th
  theme = "gruvchad",
}

-- enable and disable plugins (false for disable)
M.plugin_status = {
  colorizer = true,
}

local userPlugins = require "custom.plugins" -- path to table
-- NvChad included plugin options & overrides
M.plugins = {

  install = userPlugins,
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

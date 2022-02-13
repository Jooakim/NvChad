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
-- NvChad included plugin options & overrides
M.plugins = {
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
   -- To change the Packer `config` of a plugin that comes with NvChad,
   -- add a table entry below matching the plugin github name
   --              '-' -> '_', remove any '.lua', '.nvim' extensions
   -- this string will be called in a `require`
   --              use "(custom.configs).my_func()" to call a function
   --              use "custom.blankline" to call a file
   default_plugin_config_replace = {},
}

--vim.g.pydocstring_formatter = "numpy"
vim.g.pydocstring_doq_path = "/home/joakim/.local/bin/doq"

return M

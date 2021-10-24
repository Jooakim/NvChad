local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = { "pyright" }

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

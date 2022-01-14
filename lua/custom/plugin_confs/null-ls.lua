local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {

   -- Python
   b.formatting.black,
   b.diagnostics.flake8,
   --b.diagnostics.pylint,
   b.formatting.isort,

   -- JSON
   b.formatting.json_tool,

   -- Lua
   -- b.formatting.stylua,
   -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function(on_attach)
   null_ls.setup { 
     on_attach = on_attach,
     sources = sources,
 }
end

return M

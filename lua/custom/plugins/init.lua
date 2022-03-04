return {
  {
    "martinda/Jenkinsfile-vim-syntax",
    event = "InsertEnter",
  },
  {
    'williamboman/nvim-lsp-installer',
  },
  {
    "tpope/vim-fugitive",
    event = "InsertEnter",
  },
  {
    "cespare/vim-toml",
    event = "InsertEnter",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugin_confs.null-ls").setup()
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    requires = { "nvim-telescope/telescope.nvim" }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  },
  {
    'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" }
  },
  {
    "heavenshell/vim-pydocstring",
    event = "InsertEnter",
  },
  {
    "mfussenegger/nvim-dap"
  },
  {
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
},
{
  "rcarriga/vim-ultest",
  requires = { "vim-test/vim-test" },
  run = ":UpdateRemotePlugins"
}
}

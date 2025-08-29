return {
  -- Multi-project workspace management
  {
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup({
        hooks = {
          add = {},
          remove = {},
          rename = {},
          open_pre = {},
          open = function()
            require("nvim-tree.api").tree.toggle(false, true)
          end,
        }
      })

      -- Telescope integration
      require("telescope").load_extension("workspaces")

      -- Keybindings
      vim.keymap.set("n", "<leader>pw", require("telescope").extensions.workspaces.workspaces, { desc = "[P]roject [W]orkspaces" })
      vim.keymap.set("n", "<leader>pa", function()
        require("workspaces").add(vim.fn.getcwd())
      end, { desc = "[P]roject [A]dd workspace" })
    end,
  },

  -- Project root detection
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml", "Cargo.toml", "go.mod" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
        datapath = vim.fn.stdpath("data"),
      })
      
      -- Telescope integration
      require('telescope').load_extension('projects')
      
      -- Keybinding
      vim.keymap.set("n", "<leader>pp", require("telescope").extensions.projects.projects, { desc = "[P]roject [P]rojects" })
    end
  },

  -- Session management for projects
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = vim.opt.sessionoptions:get()
    },
    config = function(_, opts)
      require("persistence").setup(opts)
      
      -- Keybindings
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "[Q]uit and restore [S]ession" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "[Q]uit and restore [L]ast session" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "[Q]uit [D]on't save session" })
    end,
  },
}
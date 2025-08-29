return {
  -- Python environment management
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Auto select virtualenv
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      
      -- Poetry support
      poetry_path = "poetry",
      
      -- UV support  
      search = true,
      dap_enabled = false,
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)
      
      -- Keybindings
      vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "[V]env [S]elect" })
      vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCurrent<cr>", { desc = "[V]env [C]urrent" })
    end,
  },

  -- Poetry integration
  {
    "petobens/poet-v",
    ft = { "python" },
    config = function()
      -- Auto-activate poetry venv when entering Python files
      vim.g.poetv_auto_activate = 1
      
      -- Poetry commands
      vim.keymap.set("n", "<leader>pa", "<cmd>PoetvActivate<cr>", { desc = "[P]oetry [A]ctivate" })
      vim.keymap.set("n", "<leader>pd", "<cmd>PoetvDeactivate<cr>", { desc = "[P]oetry [D]eactivate" })
    end,
  },

  -- Python-specific LSP enhancements
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local lspconfig = require("lspconfig")
      
      -- Enhanced Pyright config for Poetry/uv projects
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
            -- Support for Poetry/uv project structure
            defaultInterpreterPath = "./venv/bin/python",
            venvPath = ".",
          },
        },
        on_init = function(client)
          -- Auto-detect Poetry/uv environments
          local path = require("lspconfig/util").path
          local venv_path = ""
          
          -- Check for Poetry
          if vim.fn.executable("poetry") == 1 then
            local handle = io.popen("poetry env info --path 2>/dev/null")
            if handle then
              venv_path = handle:read("*a"):gsub("%s+", "")
              handle:close()
            end
          end
          
          -- Check for uv
          if venv_path == "" and vim.fn.filereadable("uv.lock") == 1 then
            venv_path = ".venv"
          end
          
          if venv_path ~= "" and path.exists(venv_path) then
            client.config.settings.python.defaultInterpreterPath = path.join(venv_path, "bin", "python")
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
        end,
      })
    end,
  },
}